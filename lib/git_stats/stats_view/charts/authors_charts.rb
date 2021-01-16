module GitStats
  module StatsView
    module Charts
      class AuthorsCharts
        AUTHORS_ON_CHART_LIMIT = 5

        def initialize(authors)
          @authors = authors
        end

        [:insertions, :deletions, :changed_lines, :commits_sum].each do |method|
          define_method "#{method}_by_author_by_date" do |authors = nil|
            Chart.new do |f|
              f.multi_date_chart(
                data: (authors || @authors.sort_by { |a| -a.send(method) }[0...AUTHORS_ON_CHART_LIMIT]).map { |a| {name: a.name, data: a.send("#{method}_by_date")} },
                title: :lines_by_date.t,
                y_text: :lines.t
              )
            end
          end
        end
      end
    end
  end
end
