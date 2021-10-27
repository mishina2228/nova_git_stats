require 'git_stats/hash_initializable'
require 'git_stats/inspector'

module GitStats
  module GitData
    class Repo
      include GitStats::HashInitializable
      include GitStats::Inspector

      delegate :files, :files_by_extension, :files_by_extension_count, :lines_by_extension,
               :files_count, :binary_files, :text_files, :lines_count, :comments_count, to: :last_commit

      def initialize(params)
        super(params)
        @path = File.expand_path(@path)
        @tree_path ||= '.'
      end

      def path
        @path ||= '.'
      end

      attr_reader :first_commit_sha

      def last_commit_sha
        @last_commit_sha ||= 'HEAD'
      end

      def tree_path
        @tree_path ||= '.'
      end

      def comment_string
        @comment_string ||= '//'
      end

      def tree
        @tree ||= Tree.new(repo: self, relative_path: @tree_path)
      end

      def authors
        @authors ||= run_and_parse("git shortlog -se #{commit_range} #{tree_path}").map do |author|
          Author.new(repo: self, name: author[:name], email: author[:email])
        end
      end

      def commits
        command = "git rev-list --pretty=format:'%H|%at|%ai|%aE' #{commit_range} #{tree_path} | grep -v commit"
        @commits ||= run_and_parse(command).map do |commit_line|
          Commit.new(
            repo: self,
            sha: commit_line[:sha],
            stamp: commit_line[:stamp],
            date: DateTime.parse(commit_line[:date]),
            author: authors.first! { |a| a.email == commit_line[:author_email] }
          )
        end.sort_by!(&:date)
      end

      def commits_period
        commits.map(&:date).minmax
      end

      # TODO: This method is called from nowhere
      def commits_count_by_author(limit = 4)
        (authors.map { |author| [author, author.commits.size] }.sort_by { |_author, commits| -commits }[0..limit]).to_h
      end

      # TODO: These methods are called from nowhere
      [:insertions, :deletions, :changed_lines].each do |method|
        define_method "#{method}_by_author" do |limit = 4|
          (authors.map { |author| [author, author.send(method)] }.sort_by { |_author, lines| -lines }[0..limit]).to_h
        end
      end

      def files_count_by_date
        @files_count_by_date ||= commits.map do |commit|
          [commit.date.to_date, commit.files_count]
        end.to_h
      end

      def lines_count_by_date
        sum = 0
        @lines_count_by_date ||= commits.map do |commit|
          sum += commit.short_stat.insertions
          sum -= commit.short_stat.deletions
          [commit.date.to_date, sum]
        end.to_h
      end

      def comments_count_by_date
        sum = 0
        @comments_count_by_date ||= commits.map do |commit|
          sum += commit.comment_stat.insertions
          sum -= commit.comment_stat.deletions
          [commit.date.to_date, sum]
        end.to_h.fill_empty_days!(aggregated: true)
      end

      def last_commit
        commits.last
      end

      def commit_range
        first_commit_sha.blank? ? last_commit_sha : "#{first_commit_sha}..#{last_commit_sha}"
      end

      def short_stats
        @short_stats ||= commits.map(&:short_stat)
      end

      def comment_stats
        @comment_stats ||= commits.map(&:comment_stat)
      end

      def activity
        @activity ||= Activity.new(commits)
      end

      def project_version
        @project_version ||= run("git rev-parse #{commit_range}").strip
      end

      def project_name
        @project_name ||= File.expand_path(File.join(path, tree_path)).sub(File.dirname(File.expand_path(path)) + File::SEPARATOR, '')
      end

      def run(command)
        result = command_runner.run(path, command)
        invoke_command_observers(command, result)
        result
      end

      def run_and_parse(command)
        result = run(command)
        command_parser.parse(command, result)
      end

      def command_runner
        @command_runner ||= CommandRunner.new
      end

      def command_parser
        @command_parser ||= CommandParser.new
      end

      def add_command_observer(proc = nil, &block)
        command_observers << block if block
        command_observers << proc if proc
      end

      def ==(other)
        path == other.path
      end

      private

      def command_observers
        @command_observers ||= []
      end

      def invoke_command_observers(command, result)
        command_observers.each { |o| o.call(command, result) }
      end

      def ivars_to_be_displayed
        [:@path, :@tree_path, :@last_commit_sha]
      end
    end
  end
end
