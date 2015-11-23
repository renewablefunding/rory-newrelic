require "rory/newrelic/version"

require "rory"
require "newrelic_rpm"
require "new_relic/rack/agent_hooks"
require "new_relic/rack/browser_monitoring"
require "new_relic/agent/instrumentation/rack"
Rory::Application.instance.use_middleware NewRelic::Rack::BrowserMonitoring
Rory::Application.instance.use_middleware NewRelic::Rack::AgentHooks

module Rory
  class NewRelic
    attr_writer :environments, :controllers_folder, :application

    class << self
      def configure
        yield instance
        instance.hook_application
      end

      def hook_application
        instance.hook_application
      end

      def instance
        @instance ||= new
      end
    end

    def application
      @application ||= Rory.application
    end

    def controllers_folder
      @controllers_folder ||= "#{Rory.root}/controllers"
    end

    def environments
      @environments ||= %w(production development)
    end

    def hook_application
      require_relative "newrelic/obfuscator"

      if environments.include?(ENV['RORY_ENV'])
        application.class_eval do
          include ::NewRelic::Agent::Instrumentation::Rack
        end

        methods_hash.each do |klass, methods|
          klass.class_eval do
            include ::NewRelic::Agent::Instrumentation::ControllerInstrumentation
            methods.each do |method|
              add_transaction_tracer method.to_sym
            end
          end
        end
      end
    end

    def relative_file_path(filename)
      Pathname.new(filename).relative_path_from(Pathname.new(controllers_folder)).to_s.sub(/\..*/, '')
    end

    def class_name_from_filename(filename)
      Rory::Support.camelize(relative_file_path(filename))
    end

    def methods_hash
      {}.tap do |hash|
        Dir[File.expand_path(controllers_folder + '/**/*.rb')].each do |f|
          controller_class = Object.const_get(class_name_from_filename(f))
          hash[controller_class] = (controller_class.instance_methods - Rory::Controller.instance_methods).each {|m| methods << m }
        end
      end
    end
  end
end
