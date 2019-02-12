# frozen_string_literal: true

module Spree
  module Admin
    class ContentSettingsController < BaseController
      def edit
        @preferences = %w[
          sharethis_publisher_id, show_posts_on_homepage,
          show_products_on_homepage, show_taxons_on_homepage
        ]
        @config = Spree::ContentConfiguration.new
      end

      def update
        config = Spree::ContentConfiguration.new

        params.each do |name, value|
          next unless config.has_preference? name
          config[name] = value
        end

        flash[:success] = I18n.t('spree.successfully_updated', resource: I18n.t('spree.essential_content.admin.content_settings'))
        redirect_to edit_admin_content_settings_path
      end
    end
  end
end