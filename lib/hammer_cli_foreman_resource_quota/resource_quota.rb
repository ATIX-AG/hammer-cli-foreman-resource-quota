# frozen_string_literal: true

module HammerCLIForemanResourceQuota
  class ShowCommand < HammerCLIForeman::Command
    output do
      field :id, _('Id')
    end

    def adapter
      :table
    end
  end

  class ResourceQuotaCommand < HammerCLIForeman::Command
    resource :resource_quota

    class ListCommand < HammerCLIForeman::ListCommand
      output do
        field :id, _('Id')
        field :name, _('Name')
        field :created_at, _('Created at')
        field :description, _('Description')
        field :cpu_cores, _('CPU cores')
        field :memory_mb, _('Memory [MiB]')
        field :disk_gb, _('Disk space [GiB]')
        field :number_of_hosts, _('Assigned hosts')
      end
      build_options
    end

    class InfoCommand < HammerCLIForeman::InfoCommand
      output ResourceQuotaCommand::ListCommand.output_definition do
        field :number_of_users, _('Number of users')
        field :number_of_usergroups, _('Number of usergroups')
        field :number_of_missing_hosts, _('Number of missing hosts')
        label _('Utilization') do
          from :utilization do
            field :cpu_cores, _('CPU cores')
            field :memory_mb, _('Memory [MiB]')
            field :disk_gb, _('Disk space [GiB]')
          end
        end
      end
      build_options
    end

    class CreateCommand < HammerCLIForeman::CreateCommand
      success_message _('Resource quota created.')
      failure_message _('Could not create resource quota')

      option '--memory', "Memory", _('Maximum memory in MiB'), attribute_name: :memory_mb, format: HammerCLI::Options::Normalizers::Number.new
      option '--disk-space', "Disk space", _('Maximum disk space in GiB'), attribute_name: :disk_gb, format: HammerCLI::Options::Normalizers::Number.new

      build_options do |o|
        o.without('memory_mb', 'disk_gb')
      end
    end

    class DeleteCommand < HammerCLIForeman::DeleteCommand
      success_message _('Resource quota [%{name}] was deleted.')
      failure_message _('Could not delete the resource quota')

      build_options
    end

    class UpdateCommand < HammerCLIForeman::UpdateCommand
      success_message _('Resource quota [%{name}] updated.')
      failure_message _('Could not update the resource quota')

      option '--memory', "Memory", _('Maximum memory in MiB'), attribute_name: :memory_mb, format: HammerCLI::Options::Normalizers::Number.new
      option '--disk-space', "Disk space", _('Maximum disk space in GiB'), attribute_name: :disk_gb, format: HammerCLI::Options::Normalizers::Number.new

      build_options do |o|
        o.without('memory_mb', 'disk_gb')
      end
    end

    class ShowHostsCommand < ShowCommand
      action :hosts
      command_name 'show-hosts'

      output ShowCommand.output_definition do
        field :name, _('Host name')
      end

      build_options
    end

    class ShowUsergroupsCommand < ShowCommand
      action :usergroups
      command_name 'show-usergroups'

      output ShowCommand.output_definition do
        field :name, _('Usergroup name')
      end

      build_options
    end

    class ShowUsersCommand < ShowCommand
      action :users
      command_name 'show-users'

      output ShowCommand.output_definition do
        field :login, _('User name')
      end

      build_options
    end

    class UnresolvedResourcesCommand < HammerCLIForeman::Command
      action :missing_hosts
      command_name 'unresolved-resources'

      output do
        field :missing_hosts, _('Missing hosts')
      end

      build_options
    end

    autoload_subcommands
  end
end
