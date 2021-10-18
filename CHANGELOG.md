# Changelog

## [master]

[master]: https://github.com/mishina2228/git_stats/compare/v2.1.1...master

## [2.1.1]

[2.1.1]: https://github.com/mishina2228/git_stats/compare/v2.1.0...v2.1.1

### Changes

* Remove json_pure from dependency which is no longer needed
* Remove pry from development dependency

### Enhancements

* Introduced dependabot
* Run RuboCop on GitHub Action
* Fix style
* Update documents for CLI options
* Remove unneeded files from the gem package
* Use Gemfile instead of Gem::Specification#add_development_dependency

## [2.1.0]

[2.1.0]: https://github.com/mishina2228/git_stats/compare/v2.0.0...v2.1.0

### Breaking Changes

* Dropped support for IE8 and earlier

### Changes

* Updated jQuery from v1.8.2 to v3.6.0
* Updated Bootstrap from v2.1.1 to v3.3.7
  * Changed vertical tabs to horizontal
  * Changed the appearance of the hamburger icon

## 2.0.0

### Breaking Changes

* Dropped support for Ruby 2.4 and earlier
* Added support for Ruby 2.5 +

### Features

* Added `git_stats version` command
* Added graphs of changed/added/deleted lines by date for details of each author page.  
  The existing line graph shows the cumulative number, while the added bar graph shows the daily number.

### Bugfixes

* Fixed the following localization:
  * bg
  * de
  * es
  * pl
  * tr
  * zh_cn
  * zh_tw
* Returns exit 1 when a required argument is not provided

### Enhancements

* Introduced RuboCop and following extensions:
  * RuboCop Performance
  * RuboCop Rake
  * RuboCop RSpec
* Introduced HAML-Lint
* Introduced codecov
* Replaced FactoryGirl with FactoryBot
* Removed ActionPack, Introduced ActionView
* Updated following dependency gems:
  * activesupport from ~> 4.2 to ~> 6.1
  * i18n from ~> 0.8 to ~> 1.8
  * thor from ~> 0.20 to ~> 1.0
  * lazy_high_charts from ~> 1.5 to ~> 1.6
* Updated following development dependency gems:
  * pry from ~> 0.11 to ~> 0.13
  * rake from  ~> 12.0 to ~> 13.0
  * rspec from ~> 3.4 to ~> 3.10
  * simplecov from ~> 0.11 to ~> 0.21
* Updated following JavaScript libraries:
  * Highstock and data export modules from v5.0.10 to v5.0.14

## Earlier than 2.0.0

* See the original project [tomgi/git_stats](https://github.com/tomgi/git_stats)
