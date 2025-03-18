# frozen_string_literal: true

module GitStats
  class CommandParser
    def parse(command, result)
      cmd, params = command.scan(/git (.*) (.*)/).first.map(&:split).flatten
      # TODO: params is not needed?
      send(:"parse_#{cmd.underscore}", result, params)
    end

    def parse_shortlog(result, _params)
      result.lines.map do |line|
        commits, name, email = line.scan(/(.*)\t(.*)<(.*)>/).first.map(&:strip)
        {commits: commits.to_i, name: name, email: email}
      end
    end

    def parse_ls_tree(result, _params)
      result.lines.map do |line|
        mode, type, sha, filename = line.scan(/(.*) (.*) (.*)\t(.*)/).first.map(&:strip)
        {mode: mode, type: type, sha: sha, filename: filename}
      end
    end

    def parse_rev_list(result, _params)
      result.lines.grep_v(/commit/).map do |line|
        sha, stamp, date, author_email = line.split('|').map(&:strip)
        {sha: sha, stamp: stamp, date: date, author_email: author_email}
      end
    end
  end
end
