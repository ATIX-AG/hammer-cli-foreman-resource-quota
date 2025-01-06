require 'hammer_cli_foreman/user'
require 'hammer_cli_foreman_resource_quota/command_extensions/user'

module HammerCLIForemanResourceQuota
  class User < HammerCLIForeman::Command
    class InfoCommand < HammerCLIForeman::InfoCommand
      output do
        label N_('Resource quota settings') do
          field :resource_quota_is_optional, _('Resource quota is optional'), Fields::Boolean
          field :resource_quota_ids, N_('Resource quota ids')
        end
      end
    end

    class ListCommand < HammerCLIForeman::ListCommand
      output do
        field :resource_quota_is_optional, _('Resource quota optional'), Fields::Boolean
        field :resource_quota_ids, N_('Resource quota ids')
      end
    end
  end

  HammerCLIForeman::User::InfoCommand.extend_with(
    HammerCLIForemanResourceQuota::CommandExtensions::UserInfoCommand.new
  )

  HammerCLIForeman::User::ListCommand.extend_with(
    HammerCLIForemanResourceQuota::CommandExtensions::UserListCommand.new
  )
end
