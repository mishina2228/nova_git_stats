# Changelog

## [master]

[master]: https://github.com/mishina2228/nova_git_stats/compare/v2.4.1...master

* Changes
  * Add support for actionview 8
  * Add support for activesupport 8
* Bugfixes
  * Now templates are returned in alphabetical order
    * `GitStats::StatsView::View#all_templates` should return all templates in alphabetical order.
    * `Dir.[]` returns sorted results by default from Ruby 3.0, but earlier than 2.7 does not.
    * refs: 
      * https://ruby-doc.org/core-2.7.6/Dir.html#method-c-5B-5D
      * https://ruby-doc.org/core-3.0.4/Dir.html#method-c-5B-5D

## [2.4.1]

[2.4.1]: https://github.com/mishina2228/nova_git_stats/compare/v2.4.0...v2.4.1

* Changes
  * Relax activesupport version from `>= 6.1` to `>= 5.2`
  * Replace deprecated DateTime with Time
  * Support Haml 6

## [2.4.0]

[2.4.0]: https://github.com/mishina2228/nova_git_stats/compare/v2.3.0...v2.4.0

* Bugfixes
  * Renamed CLI option name `--tree` to `--tree-path`
    * **This is a potentially breaking change.**
    * `--tree` and `-d` did not work before.  
      The CLI option name was `--tree`, but an internal variable name was `tree-path`, and there was a mismatch.  
      So we changed the CLI option name `--tree` to `--tree-path`.  

## [2.3.0]

[2.3.0]: https://github.com/mishina2228/nova_git_stats/compare/v2.2.0...v2.3.0

* Breaking Changes
  * Stop bundling jQuery and Bootstrap assets
    * Those libraries are delivered by CDN, so an Internet connection is required now.

* Changes
  * Enable `frozen_string_literal` by adding the magic comment to all files
  * Updated Bootstrap from v3.3.7 to v5.0.2

* Enhancements
  * Include documents and license in the package
  * Replace the project name with new one in the visible part

* Bugfixes
  * Fixed highlighting of active tabs

## [2.2.0]

[2.2.0]: https://github.com/mishina2228/nova_git_stats/compare/v2.1.2...v2.2.0

* Features
  * Renamed to NovaGitStats(nova_git_stats) from GitStats(git_stats)

## [2.1.2]

[2.1.2]: https://github.com/mishina2228/nova_git_stats/compare/v2.1.1...v2.1.2

* Features
  * Add `GitStats.version` method

* Changes
  * Move `HashInitializable` under `GitStats` namespace
  * Add support for actionview 7.0
  * Add support for activesupport 7.0

* Bugfixes
  * Expand `path` and `out_path` to the absolute path
    * Previously, when the following command was executed, the result was saved in `./~/output/`.

      ```sh
      git_stats generate -o ~/output/
      ```

      It has been fixed so that the results are saved in `~/output` now.

* Enhancements
  * Introduce `Update GitStats::Inspector` for debugging
    * Define `#to_s`, `#inspect` and `#pretty_print` to reduce the amount of information displayed by those methods.
  * Replace `require` with `require_relative` if possible

## [2.1.1]

[2.1.1]: https://github.com/mishina2228/nova_git_stats/compare/v2.1.0...v2.1.1

* Changes
  * Remove json_pure from dependency which is no longer needed
  * Remove pry from development dependency

* Enhancements
  * Introduced dependabot
  * Run RuboCop on GitHub Action
  * Fix style
  * Update documents for CLI options
  * Remove unneeded files from the gem package
  * Use Gemfile instead of Gem::Specification#add_development_dependency

## [2.1.0]

[2.1.0]: https://github.com/mishina2228/nova_git_stats/compare/v2.0.0...v2.1.0

* Breaking Changes
  * Dropped support for IE8 and earlier

* Changes
  * Updated jQuery from v1.8.2 to v3.6.0
  * Updated Bootstrap from v2.1.1 to v3.3.7
    * Changed vertical tabs to horizontal
    * Changed the appearance of the hamburger icon

## 2.0.0

* Breaking Changes
  * Dropped support for Ruby 2.4 and earlier
  * Added support for Ruby 2.5 +

* Features
  * Added `git_stats version` command
  * Added graphs of changed/added/deleted lines by date for details of each author page.  
    The existing line graph shows the cumulative number, while the added bar graph shows the daily number.

* Bugfixes
  * Fixed the following localization:
    * bg
    * de
    * es
    * pl
    * tr
    * zh_cn
    * zh_tw
  * Returns exit 1 when a required argument is not provided

* Enhancements
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
