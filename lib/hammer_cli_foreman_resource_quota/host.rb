require 'hammer_cli_foreman/host'
require 'hammer_cli_foreman_resource_quota/command_extensions/host'

module HammerCLIForemanResourceQuota
  class Host < HammerCLIForeman::Command
    class InfoCommand < HammerCLIForeman::InfoCommand
      output do
        field :resource_quota_id, _('Resource quota id')
      end
    end
  end

  HammerCLIForeman::Host::InfoCommand.extend_with(
    HammerCLIForemanResourceQuota::CommandExtensions::Host.new
  )
end
