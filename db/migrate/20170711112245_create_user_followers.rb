class CreateUserFollowers < ActiveRecord::Migration
  def change
    create_table :user_followers do |t|
      t.references  :followee, foreign_key: true, index: true
      t.references  :follower, foreign_key: true, index: true
      t.timestamps null: false
    end
  end
end
