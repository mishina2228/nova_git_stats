module GitStats
  module StatsView
    module Charts
      class AuthorsCharts
        AUTHORS_ON_CHART_LIMIT = 5

        def initialize(authors)
          @authors = authors
        end

        [:commits_sum].each do |method|
          define_method "#{method}_by_author_by_date" do |authors = nil|
            Chart.new do |f|
              authors ||= @authors.sort_by { |a| -a.send(method) }[0...AUTHORS_ON_CHART_LIMIT]
              f.multi_date_chart(
                data: authors.map { |a| {name: a.name, data: a.send("#{method}_by_date")} },
                title: :lines_by_date.t,
                y_text: :lines.t
              )
            end
          end
        end

        [:insertions, :deletions, :changed_lines].each do |method|
          define_method "total_#{method}_by_author_by_date" do |authors = nil|
            Chart.new do |f|
              authors ||= @authors.sort_by { |a| -a.send(method) }[0...AUTHORS_ON_CHART_LIMIT]
              f.multi_date_chart(
                data: authors.map { |a| {name: a.name, data: a.send("total_#{method}_by_date")} },
                title: :lines_by_date.t,
                y_text: :lines.t
              )
            end
          end

          define_method "#{method}_by_author_by_date" do |author|
            Chart.new do |f|
              f.date_column_chart(
                data: author.send("#{method}_by_date"),
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
