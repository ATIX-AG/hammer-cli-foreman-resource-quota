module HammerCLIForemanResourceQuota
  module CommandExtensions
    class UsergroupCommand < HammerCLI::CommandExtensions
      output do |definition|
        definition.append(HammerCLIForemanResourceQuota::Usergroup::UsergroupCommand.output_definition.fields)
      end
    end
  end
end
