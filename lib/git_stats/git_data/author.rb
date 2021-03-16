require 'git_stats/hash_initializable'

module GitStats
  module GitData
    class Author
      include HashInitializable

      attr_reader :repo, :name, :email

      def commits
        @commits ||= repo.commits.select { |commit| commit.author == self }
      end

      def commits_sum
        commits.size
      end

      def changed_lines
        insertions + deletions
      end

      def insertions
        short_stats.sum(&:insertions)
      end

      def deletions
        short_stats.sum(&:deletions)
      end

      def commits_sum_by_date
        sum = 0
        commits.map do |commit|
          sum += 1
          [commit.date, sum]
        end
      end

      [:insertions, :deletions, :changed_lines].each do |method|
        define_method "#{method}_by_date" do
          sum = 0
          commits.map do |commit|
            sum += commit.short_stat.send(method)
            [commit.date, sum]
          end
        end

        define_method "#{method}2_by_date" do
          commits.group_by { |c| c.date.to_date }.map { |arr| [arr[0], arr[1].sum { |c| c.short_stat.send(method) }] }
        end
      end

      def short_stats
        commits.map(&:short_stat)
      end

      def activity
        @activity ||= Activity.new(commits)
      end

      def dirname
        @name.underscore.split.join '_'
      end

      def to_s
        "#{self.class} #{@name} <#{@email}>"
      end

      def ==(other)
        [repo, name, email] == [other.repo, other.name, other.email]
      end
    end
  end
end
