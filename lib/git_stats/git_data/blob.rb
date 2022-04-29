# frozen_string_literal: true

require_relative '../hash_initializable'
require_relative '../inspector'

module GitStats
  module GitData
    class Blob
      include GitStats::HashInitializable
      include GitStats::Inspector

      attr_reader :repo, :sha, :filename

      def lines_count
        @lines_count ||= binary? ? 0 : repo.run("git cat-file blob #{sha} | wc -l").to_i
      end

      def content
        @content ||= repo.run("git cat-file blob #{sha}")
      end

      def extension
        @extension ||= File.extname(filename)
      end

      def binary?
        repo.run("git cat-file blob #{sha} | grep -m 1 '^'").dup
            .force_encoding('ISO-8859-1').encode('utf-8', replace: nil)
            .include?('Binary file')
      end

      def ==(other)
        [repo, sha, filename] == [other.repo, other.sha, other.filename]
      end

      private

      def ivars_to_be_displayed
        [:@sha, :@filename]
      end
    end
  end
end
