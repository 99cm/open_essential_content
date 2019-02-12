# frozen_string_literal: true

class Spree::PageImage < Spree::Asset
  include Image::ActiveStorage
  include Rails.application.routes.url_helpers

  def styles
    self.class.styles.map do |_, size|
      width, height = size[/(\d+)x(\d+)/].split('x')

      {
        url: polymorphic_path(attachment.pages(resize: size), only_path: true),
        width: width,
        height: height
      }
    end
  end

  def image_content?
    styles.merge!(mini: '48x48>', small: '150x150>', medium: '420x300>', large: '900x650>')
    styles[:slide] = '950x250#' if viewable.respond_to?(:root?) && viewable.root?
  end
end