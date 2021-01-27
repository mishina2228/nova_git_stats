# Changelog

## Master

### Breaking Changes
* Dropped support for Ruby 2.4 and earlier
* Added support for Ruby 2.5 +

### Features
* Added `git_stats version` command

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
