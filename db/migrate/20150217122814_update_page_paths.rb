class UpdatePagePaths < ActiveRecord::Migration[5.2]
  def up
    Spree::Page.all.each do |f|
      f.update_attribute :path, Spree::Page.normalize_path(f.path)
    end
  end

  def down

  end
end
