require 'hammer_cli_foreman/usergroup'
require 'hammer_cli_foreman_resource_quota/command_extensions/usergroup'

module HammerCLIForemanResourceQuota
  class Usergroup < HammerCLIForeman::Command
    class UsergroupCommand < HammerCLIForeman::InfoCommand
      output do
        field :resource_quota_ids, N_('Resource quota ids')
      end
    end
  end

  HammerCLIForeman::Usergroup::InfoCommand.extend_with(
    HammerCLIForemanResourceQuota::CommandExtensions::UsergroupCommand.new
  )

  HammerCLIForeman::Usergroup::ListCommand.extend_with(
    HammerCLIForemanResourceQuota::CommandExtensions::UsergroupCommand.new
  )
end
