class CreateUserRequests < ActiveRecord::Migration
  def change
    create_table :user_requests do |t|

      t.references  :request_followee, foreign_key: true, index: true
      t.references  :request_follower, foreign_key: true, index: true
	
      t.timestamps null: false
    end
  end
end
