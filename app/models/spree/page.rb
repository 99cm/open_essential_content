# frozen_string_literal: true

class Spree::Page < ActiveRecord::Base
  extend FriendlyId
  friendly_id :path

  acts_as_list

  RESERVED_PATHS = /(^\/+(admin|account|en|es|cart|checkout|content|login|logout|pg\/|orders|products|s\/|session|signup|shipments|states|t\/|tax_categories|user)+)/

  alias_attribute :name, :title

  belongs_to :store
  has_many :stores, join_table: 'spree_pages_stores'

  validates_presence_of :title
  validates :path, presence: true, uniqueness: { case_sensitive: false }

  scope :active, -> { where(accessible: true) }
  scope :visible, -> { active.where(visible: true) }
  scope :header_links, -> { where(show_in_header: true).visible }
  scope :footer_links, -> { where(show_in_footer: true).visible }

  scope :by_store, lambda { |store| joins(:stores).where("spree_pages_stores.store_id = ?", store) }

  has_many :contents, -> { order(:position) }, dependent: :destroy
  has_many :images, -> { order(:position) }, as: :viewable, class_name: 'Spree::PageImage', dependent: :destroy
  before_validation :set_defaults
  after_create :create_default_content

  translates :title, :nav_title, :path, :meta_title, :meta_description, :meta_keywords, fallbacks_for_empty_translations: true
  include OpenGlobalize::Translatable

  self.whitelisted_ransackable_attributes = %w[title path]

  def self.find_by_path(_path)
    return where(path: '__home__').first if ((_path == '__home__') || (_path == '/') && exists?(path: '/')
    where(path: normalize_path(_path)).first
  end

  def to_param
    path
  end

  def meta_title
    val = read_attribute(:meta_title)
    val.blank? ? title : val
  end

  def for_context(context)
    contents.where(context: context)
  end

  def has_context?(context)
    contents.where(context: context).count > 0
  end

  def matches?(_path)
    (root? && _path == '') || (!root? && _path.match(path))
  end

  def root?
    path == '__home__'
  end

  def self.normalize_path(original_path)
    if original_path == '/'
      '__home__'
    else
      original_path.downcase.gsub(/(^[\/\-\_]+)|([\/\-\_]+$)/, '')
    end
  end

  private

  def set_defaults
    return if title.blank?
    self.nav_title = title if nav_title.blank?
    self.path = nav_title.parameterize if path.blank?
    self.path = self.class.normalize_path(path)
  end

  def create_default_content
    contents.create(title: title)
  end
end