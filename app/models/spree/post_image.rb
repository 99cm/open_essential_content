# frozen_string_literal: true

class Spree::PostImage < Spree::Asset
  include Image::ActiveStorage
  include Rails.application.routes.url_helpers    

  def styles
    self.class.styles.map do |_, size|
      width, height = size[/(\d+)x(\d+)/].split('x')

      {
        url: polymorphic_path(attachment.posts(resize: size), only_path: true),
        width: width,
        height: height
      }
    end
  end
end