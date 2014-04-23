class AddTimeForVotes < ActiveRecord::Migration
  def change
  	add_column :votes, :created_at, :datetime
  end
end
