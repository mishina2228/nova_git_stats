module GitStats
  def self.root
    Pathname.new(File.dirname(File.dirname(__FILE__)))
  end
end

require 'active_support/all'
require 'fileutils'
require 'tilt'
require 'pathname'
require 'lazy_high_charts'
require 'i18n'

require 'git_stats/base'
