class AddSpreeNamespace < ActiveRecord::Migration[5.2]
  def up
    rename_table :contents, :spree_contents
    rename_table :pages, :spree_pages
  end

  def down
    rename_table :spree_contents, :contents
    rename_table :spree_pages, :pages
  end
end
