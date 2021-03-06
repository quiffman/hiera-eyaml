require 'hiera/backend/eyaml/subcommand'
require 'hiera/backend/eyaml'

class Hiera
  module Backend
    module Eyaml
      module Subcommands

        class Version < Subcommand

          def self.options
            []
          end

          def self.description
            "show version information"
          end

          def self.execute
            plugin_versions = {}

            puts <<-EOS
Version info

hiera-eyaml (core): #{Eyaml::VERSION}
EOS

            Plugins.plugins.each do |plugin|
              plugin_shortname = plugin.name.split("hiera-eyaml-").last
              plugin_version = begin
                Encryptor.find(plugin_shortname)::VERSION.to_s
              rescue
                "unknown (is plugin compatible with eyaml 2.0+ ?)"
              end
              puts "    hiera-eyaml-#{plugin_shortname} (gem): #{plugin_version}"
            end

            nil
            
          end

        end

      end
    end
  end
end