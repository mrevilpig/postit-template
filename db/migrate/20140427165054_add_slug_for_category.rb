class AddSlugForCategory < ActiveRecord::Migration
  def change
    add_column :categories, :slug, :string
  end
end
