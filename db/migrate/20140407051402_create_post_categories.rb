class CreatePostCategories < ActiveRecord::Migration
  def up
    create_table :post_categories do |t|
    	t.integer :post_id
    	t.integer :category_id
    end
  end

  def down
  	drop_table :post_categories
  end
end
