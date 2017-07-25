class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
 	  
 	  t.references :post
      t.references :user

      t.timestamps null: false
    end
  end
end
