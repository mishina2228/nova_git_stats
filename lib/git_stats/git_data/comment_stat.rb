module GitStats
  module GitData
    class CommentStat
      attr_reader :commit, :insertions, :deletions

      def initialize(commit)
        @commit = commit
        calculate_stat
      end

      def changed_lines
        insertions + deletions
      end

      def escape_characters_in_string(string)
        pattern = %r{['".*/\\-]}
        string.gsub(pattern) { |match| "\\#{match}" }
      end

      private

      def calculate_stat
        escaped_string = escape_characters_in_string(commit.repo.comment_string)
        command = "git show #{commit.sha} | " \
                  "awk 'BEGIN {adds=0; dels=0} " \
                  "{if ($0 ~ /^\\+#{escaped_string}/) adds++; if ($0 ~ /^\-#{escaped_string}/) dels++} " \
                  "END {print adds \" insertions \" dels \" deletes\"}'"
        stat_line = commit.repo.run(command).lines.to_a[0]
        if stat_line.blank?
          @insertions = @deletions = 0
        else
          @insertions = stat_line[/(\d+) insertions?/, 1].to_i
          @deletions = stat_line[/(\d+) deletes?/, 1].to_i
        end
      end
    end
  end
end
