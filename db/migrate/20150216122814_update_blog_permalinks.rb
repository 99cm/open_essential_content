class UpdateBlogPermalinks < ActiveRecord::Migration[5.2]
  def up
    Spree::Blog.all.each do |f|
      f.update_attribute :permalink, Spree::Blog.normalize_permalink(f.permalink)
    end
  end

  def down

  end
end