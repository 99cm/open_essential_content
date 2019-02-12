require 'Open_core'
require 'acts-as-taggable-on'

require 'open_essential_content/engine'

module Spree
  class PossiblePage
    def self.matches?(request)
      path = request.path.gsub(/#{OpenI18n::Config.available_locales.join('|')}\//, '').sub(%r{^/}, '')
      return false if request.path =~ Spree::Page::RESERVED_PATHS
      Spree::Page.joins(:translations).active.where(path: Spree::Page.normalize_path(request.path)).any?
    end
  end

  class PossibleBlog
    def self.matches?(request)
      return false if request.path =~ Spree::Blog::RESERVED_PATHS
      path = request.path
      path = path.sub(%r{^/},"").split(%r{/\s*}).reject {|p| OpenI18n::Config.available_locales.include? p.to_sym}
      path = path.sub(%r{^/},'').split(%r{/\s*})[0].tap{|s| s.slice!('.rss')} unless path == '/'
      Spree::Blog.joins(:translations).where(permalink: Spree::Blog.normalize_permalink(path)).any?
    end
  end
end