module HammerCLIForemanResourceQuota
  require 'hammer_cli'
  require 'hammer_cli_foreman'
  require 'hammer_cli_foreman/host'
  # require 'hammer_cli_foreman/hostgroup'

  require 'hammer_cli_foreman_resource_quota/version'
  require 'hammer_cli_foreman_resource_quota/host'
  require 'hammer_cli_foreman_resource_quota/i18n'
  require 'hammer_cli_foreman_resource_quota/resource_quota'
  require 'hammer_cli_foreman_resource_quota/command_extensions'

  HammerCLI::MainCommand.lazy_subcommand(
    'resource-quota',
    'Manage foreman resource quotas',
    'HammerCLIForemanResourceQuota::ResourceQuotaCommand',
    'hammer_cli_foreman_resource_quota/resource_quota'
  )
end
