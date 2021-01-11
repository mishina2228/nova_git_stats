module GitStats
  module StatsView
    class View
      def initialize(view_data, out_path)
        @view_data = view_data
        @out_path = out_path
        @layout = Tilt.new("../../../../templates/layout.haml".absolute_path)
      end

      def render_all
        prepare_static_content
        prepare_assets

        all_templates.reject {|t| t.include?('author_details')}.each do |template|
          output = Template.new(template, @layout).render(@view_data, author: @view_data.repo, links: links)
          write(output, "#{@out_path}/#{template}.html")
        end

        render_authors
      end

      def render_authors
        done = []
        @view_data.repo.authors.sort_by { |a| -a.commits.size }.each do |author|
          next if done.include? author.dirname

          done << author.dirname
          (all_templates('activity/') + all_templates('author_details')).each do |template|
            output = Template.new(template, @layout).render(@view_data,
                                                            author: author,
                                                            links: links,
                                                            active_page: "/authors/#{author.dirname}/#{template}")
            write(output, "#{@out_path}/authors/#{author.dirname}/#{template}.html")
          end
        end
      end

      def all_templates(root = '')
        (Dir["../../../../templates/#{root}**/[^_]*.haml".absolute_path].map do |f|
          path = Pathname.new(f)
          path.relative_path_from(Pathname.new('../../../../templates'.absolute_path)).sub_ext('').to_s
        end - %w(layout))
      end

      private

      def write(output, write_file)
        FileUtils.mkdir_p(File.dirname(write_file))
        File.open(write_file, 'w') { |f| f.write output }
      end

      def links
        {
          general: 'general.html',
          activity: 'activity/by_date.html',
          authors: 'authors/best_authors.html',
          files: 'files/by_date.html',
          lines: 'lines/by_date.html',
          comments: 'comments/by_date.html'
        }
      end

      def prepare_static_content
        create_out_dir
        FileUtils.cp_r(Dir["../../../../templates/static/*".absolute_path], @out_path)
      end

      def create_out_dir
        FileUtils.mkdir_p(@out_path) unless Dir.exist?(@out_path)
      end

      def prepare_assets
        FileUtils.cp_r('../../../../templates/assets'.absolute_path, @out_path)
      end
    end
  end
end
