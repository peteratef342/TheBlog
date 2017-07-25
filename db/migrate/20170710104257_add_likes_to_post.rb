class AddLikesToPost < ActiveRecord::Migration
  def change
    add_column :posts, :likes_num, :integer,  :default => 0
  end
end
