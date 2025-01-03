require 'rake/testtask'
require 'bundler/gem_tasks'

Bundler::GemHelper.install_tasks

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = true
  t.warning = ENV.key?('RUBY_WARNINGS')
end

namespace :pkg do
  desc 'Generate package source gem'
  task generate_source: :build
end

require 'hammer_cli_foreman_resource_quota/version'
require 'hammer_cli_foreman_resource_quota/i18n'
require 'hammer_cli/i18n/find_task'
HammerCLI::I18n::FindTask.define(HammerCLIForemanResourceQuota::I18n::LocaleDomain.new, HammerCLIForemanResourceQuota.version.to_s)

begin
  require 'rubocop/rake_task'
rescue LoadError
  # RuboCop is optional
  task default: :test
else
  RuboCop::RakeTask.new
  task default: [:rubocop, :test]
end
