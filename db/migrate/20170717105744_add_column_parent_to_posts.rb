class AddColumnParentToPosts < ActiveRecord::Migration
  def change
  	    add_reference :posts, :parent_post , foreign_key: true, :null => true
  end
end
