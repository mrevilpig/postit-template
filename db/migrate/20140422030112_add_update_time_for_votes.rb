class AddUpdateTimeForVotes < ActiveRecord::Migration
  def change
  	add_column :votes, :updated_at, :datetime
  end
end
