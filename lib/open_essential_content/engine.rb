module OpenEssentialContent
  class Engine < Rails::Engine
    require 'open/core'
    isolate_namespace Spree
    engine_name 'open_essential_content'

    #initializer "spree.essential_content.preferences", :before => :load_config_initializers do |app|
    #  Spree::EssentialContent::Config = Spree::BlogConfiguration.new
    #end

    config.autoload_paths += %W(#{config.root}/lib)

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end

      Dir.glob File.expand_path("../../../app/overrides/**/*.rb", __FILE__) do |c|
        Rails.application.config.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end