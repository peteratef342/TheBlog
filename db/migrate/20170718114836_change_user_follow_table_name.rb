class ChangeUserFollowTableName < ActiveRecord::Migration
  def change
  	rename_table :user_requests, :follow_requests
  end
end
