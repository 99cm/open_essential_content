# frozen_string_literal: true

class Spree::Content < ActiveRecord::Base
  include Image::ActiveStorage
  include Rails.application.routes.url_helpers

  translates :title, :body, :link, :link_text, :context, fallbacks_for_empty_translations: true
  include OpenGlobalize::Translatable

  attr_accessor :delete_attachment

  acts_as_list scope: :page

  belongs_to :page
  validates_associated :page
  validates_presence_of :title, :page

  def styles
    self.class.styles.map do |_, size|
      width, height = size[/(\d+)x(\d+)/].split('x')

      {
        url: polymorphic_path(attachment.contents(resize: size), only_path: true),
        width: width,
        height: height
      }
    end
  end

  cattr_reader :per_page
  @@per_page = 10

  scope :for, Proc { |context| where(context: context) }

  before_update :delete_attachment!, if: :delete_attachment
  # before_update :reprocess_images_if_context_changed

  %i[link_text link body].each do |property|
    define_method "has_#{property}?" do
      has_value property
    end
  end

  def has_full_link?
    has_link? && has_link_text?
  end

  def hide_title?
    hide_title == true
  end

  def rendered_body
    body&.html_safe
  end

  def default_styles
    { large: '1200x630>', medium: '600x315>', small: '200x200>', mini: '48x48>' }
  end

  def self.context
    when 'slideshow'
      default_styles.merge(slide: '955x476#')
    else
      default_styles
  end
        
  def context=(value)
    write_attribute :context, value.to_s.parameterize
  end

  private

  def delete_attachment!
    del = delete_attachment.to_s
    self.attachment = nil if del == '1' || del == 'true'
    true
  end

  def reprocess_images_if_context_changed
    return unless context_changed? && attachment_file_name.present?
    attachment.reprocess!
  end

  def has_value(selector)
    v = send selector
    v && !v.to_s.blank?
  end
end