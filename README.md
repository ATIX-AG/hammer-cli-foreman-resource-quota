# Hammer CLI Foreman Resource Quota

This Hammer CLI plugin contains set of commands for [foreman_resource_quota](
  https://github.com/atix-ag/foreman_resource_quota
), a plugin to Foreman for Resource Quotas.

## Versions

This is the list of which version of Foreman Resource Quota is needed to which version of this plugin.

| hammer_cli_foreman_resource_quota | 0.0.1+ |
|-----------------------------------|--------|
|            foreman_resource_quota | 0.3.1+ |

## Installation

    $ gem install hammer_cli_foreman_resource_quota

    $ mkdir -p ~/.hammer/cli.modules.d/

    $ cat <<EOQ > ~/.hammer/cli.modules.d/foreman_resource_quota.yml
    :foreman_resource_quota:
      :enable_module: true
    EOQ

    # to confirm things work, this should return useful output
    hammer resource_quota --help

## More info

See our [Hammer CLI installation and configuration instuctions](
https://github.com/theforeman/hammer-cli/blob/master/doc/installation.md#installation).
