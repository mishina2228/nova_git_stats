# frozen_string_literal: true

module GitStats
  module StatsView
    class Template
      def initialize(name, layout = nil)
        @name = name
        @layout = layout
        @template = Tilt.new(GitStats.root.join("templates/#{@name}.haml"))
      end

      def render(data, params = {})
        if @layout
          @layout.render(data, active_page: params[:active_page] || @name, links: params[:links]) do
            @template.render(data, params)
          end
        else
          @template.render(data, params)
        end
      end
    end
  end
end
