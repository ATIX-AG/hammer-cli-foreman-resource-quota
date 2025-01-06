module HammerCLIForemanResourceQuota
  module CommandExtensions
    class UserInfoCommand < HammerCLI::CommandExtensions
      output do |definition|
        definition.append(HammerCLIForemanResourceQuota::User::InfoCommand.output_definition.fields)
      end
    end

    class UserListCommand < HammerCLI::CommandExtensions
      output do |definition|
        definition.append(HammerCLIForemanResourceQuota::User::ListCommand.output_definition.fields)
      end
    end
  end
end
