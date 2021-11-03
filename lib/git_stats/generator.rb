require_relative 'inspector'

module GitStats
  class Generator
    include GitStats::Inspector

    delegate :add_command_observer, to: :@repo
    delegate :render_all, to: :@view

    attr_reader :path, :out_path

    def initialize(options)
      @path = validate_repo_path(options[:path])
      @out_path = File.expand_path(options[:out_path])

      @repo = GitData::Repo.new(options.merge(path: path))
      view_data = StatsView::ViewData.new(@repo)
      @view = StatsView::View.new(view_data, out_path)

      yield self if block_given?
    end

    private

    def validate_repo_path(repo_path)
      raise ArgumentError, '`path` is not specified' unless repo_path

      path = File.expand_path(repo_path)
      raise ArgumentError, "'#{path}' is not a git repository" unless valid_repo_path?(path)

      path
    end

    def valid_repo_path?(repo_path)
      Dir.exist?("#{repo_path}/.git") || File.exist?("#{repo_path}/.git") || File.exist?("#{repo_path}/HEAD")
    end
  end
end
