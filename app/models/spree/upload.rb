# frozen_string_literal: true

class Spree::Upload < Spree::Asset
  include Image::ActiveStorage
  include Rails.application.routes.url_helpers

  def styles
    self.class.styles.map do |_, size|
      width, height = size[/(\d+)x(\d+)/].split('x')

      {
        url: polymorphic_path(attachment.uploads(resize: size), only_path: true),
        width: width,
        height: height
      }
    end
  end

  self.whitelisted_ransackable_attributes = %w[alt attachment_file_name]

  def has_alt?
    alt.present?
  end
end