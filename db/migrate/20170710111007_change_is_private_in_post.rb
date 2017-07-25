class ChangeIsPrivateInPost < ActiveRecord::Migration
  def change
  	change_column :posts, :is_private, :integer
  	rename_column :posts, :is_private, :privacy
  end
end
