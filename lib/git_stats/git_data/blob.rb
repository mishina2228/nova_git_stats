require 'git_stats/hash_initializable'

module GitStats
  module GitData
    class Blob
      include HashInitializable

      attr_reader :repo, :sha, :filename

      def lines_count
        @lines_count ||= binary? ? 0 : repo.run("git cat-file blob #{sha} | wc -l").to_i
      end

      def content
        @content ||= repo.run("git cat-file blob #{sha}")
      end

      def extension
        @ext ||= File.extname(filename)
      end

      def binary?
        repo.run("git cat-file blob #{sha} | grep -m 1 '^'").force_encoding('ISO-8859-1').encode('utf-8', replace: nil) =~ /Binary file/
      end

      def to_s
        "#{self.class} #{@sha} #{@filename}"
      end

      def ==(other)
        [repo, sha, filename] == [other.repo, other.sha, other.filename]
      end
    end
  end
end
