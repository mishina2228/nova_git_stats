require 'git_stats/hash_initializable'

module GitStats
  module GitData
    class Commit
      include HashInitializable

      attr_reader :repo, :sha, :stamp, :date, :author

      def files
        @files ||= repo.run_and_parse("git ls-tree -r #{sha} -- #{repo.tree_path}").map do |file|
          Blob.new(repo: repo, filename: file[:filename], sha: file[:sha])
        end
      end

      def binary_files
        @binary_files ||= files.select(&:binary?)
      end

      def text_files
        @text_files ||= files - binary_files
      end

      def files_by_extension
        @files_by_extension ||= files.each_with_object({}) do |f, acc|
          acc[f.extension] ||= []
          acc[f.extension] << f
        end
      end

      def files_by_extension_count
        @files_by_extension_count ||= files_by_extension.transform_values(&:count)
      end

      def lines_by_extension
        @lines_by_extension ||= files_by_extension.map do |ext, files|
          next if (lines_count = files.sum(&:lines_count)) == 0

          [ext, lines_count]
        end.compact.to_h
      end

      def files_count
        @files_count ||= repo.run("git ls-tree -r --name-only #{sha} -- #{repo.tree_path}| wc -l").to_i
      end

      def lines_count
        command = "git diff --shortstat --no-renames `git hash-object -t tree /dev/null` #{sha} -- #{repo.tree_path}"
        @lines_count ||= repo.run(command).lines.sum do |line|
          line[/(\d+) insertions?/, 1].to_i
        end
      end

      def short_stat
        @short_stat ||= ShortStat.new(self)
      end

      def comment_stat
        @comment_stat ||= CommentStat.new(self)
      end

      def to_s
        "#{self.class} #{@sha}"
      end

      def ==(other)
        [repo, sha, stamp, date, author] ==
          [other.repo, other.sha, other.stamp, other.date, other.author]
      end
    end
  end
end
