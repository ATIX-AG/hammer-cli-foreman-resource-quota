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

      build_options do |o|
        o.without('location_id', 'organization_id')
        o.expand.except(:locations, :organizations)
      end
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

      build_options do |o|
        o.without('location_id', 'organization_id')
        o.expand.except(:locations, :organizations)
      end
    end

    class CreateCommand < HammerCLIForeman::CreateCommand
      success_message _('Resource quota created.')
      failure_message _('Could not create resource quota')

      option '--memory', "Memory", _('Maximum memory in MiB'), attribute_name: :option_memory_mb, format: HammerCLI::Options::Normalizers::Number.new
      option '--disk-space', "Disk space", _('Maximum disk space in GiB'), attribute_name: :option_disk_gb, format: HammerCLI::Options::Normalizers::Number.new

      build_options do |o|
        o.expand.except(:locations, :organizations)
        o.without('memory_mb', 'disk_gb', 'location_id', 'organization_id')
      end
    end

    class DeleteCommand < HammerCLIForeman::DeleteCommand
      success_message _('Resource quota "%{name}" was deleted.')
      failure_message _('Could not delete the resource quota')

      build_options do |o|
        o.without('location_id', 'organization_id')
        o.expand.except(:locations, :organizations)
      end
    end

    class UpdateCommand < HammerCLIForeman::UpdateCommand
      success_message _('Resource quota "%{name}" updated.')
      failure_message _('Could not update the resource quota')

      option '--memory', "Memory", _('Maximum memory in MiB'), attribute_name: :option_memory_mb, format: HammerCLI::Options::Normalizers::Number.new
      option '--disk-space', "Disk space", _('Maximum disk space in GiB'), attribute_name: :option_disk_gb, format: HammerCLI::Options::Normalizers::Number.new
      option '--remove-memory-limit', :flag, _('Remove quota limit for memory')
      option '--remove-disk-space-limit', :flag, _('Remove quota limit for disk space')
      option '--remove-cpu-cores-limit', :flag, _('Remove quota limit for CPU cores')

      validate_options do
        if option(:option_remove_memory_limit).exist? && option(:option_memory_mb).exist?
          raise ArgumentError, _("You cannot set '--remove-memory-limit' and '--memory' options at the same time")
        end
        if option(:option_remove_disk_space_limit).exist? && option(:option_disk_gb).exist?
          raise ArgumentError, _("You cannot set '--remove-disk-space-limit' and '--disk-space' options at the same time")
        end
        if option(:option_remove_cpu_cores_limit).exist? && option(:option_cpu_cores).exist?
          raise ArgumentError, _("You cannot set '--remove-cpu-cores-limit' and '--cpu-cores' options at the same time")
        end
      end

      def request_params
        super.tap do |opts|
          opts['resource_quota']['memory_mb'] = nil if option_remove_memory_limit?
          opts['resource_quota']['disk_gb'] = nil if option_remove_disk_space_limit?
          opts['resource_quota']['cpu_cores'] = nil if option_remove_cpu_cores_limit?
        end
      end

      build_options do |o|
        o.without('memory_mb', 'disk_gb', 'location_id', 'organization_id')
        o.expand.except(:locations, :organizations)
      end
    end

    class ShowHostsCommand < ShowCommand
      action :hosts
      command_name 'show-hosts'

      output ShowCommand.output_definition do
        field :name, _('Host name')
      end

      build_options do |o|
        o.without('location_id', 'organization_id')
        o.expand.except(:locations, :organizations)
      end
    end

    class ShowUsergroupsCommand < ShowCommand
      action :usergroups
      command_name 'show-usergroups'

      output ShowCommand.output_definition do
        field :name, _('Usergroup name')
      end

      build_options do |o|
        o.without('location_id', 'organization_id')
        o.expand.except(:locations, :organizations)
      end
    end

    class ShowUsersCommand < ShowCommand
      action :users
      command_name 'show-users'

      output ShowCommand.output_definition do
        field :login, _('User name')
      end

      build_options do |o|
        o.without('location_id', 'organization_id')
        o.expand.except(:locations, :organizations)
      end
    end

    class UnresolvedResourcesCommand < HammerCLIForeman::Command
      action :missing_hosts
      command_name 'unresolved-resources'

      output do
        field :missing_hosts, _('Missing hosts')
      end

      build_options do |o|
        o.without('location_id', 'organization_id')
        o.expand.except(:locations, :organizations)
      end
    end

    autoload_subcommands
  end
end
