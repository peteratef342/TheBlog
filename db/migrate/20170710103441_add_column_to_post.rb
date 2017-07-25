class AddColumnToPost < ActiveRecord::Migration
  def change
    add_column :posts, :is_private, :bool, :default => false
  end
end
