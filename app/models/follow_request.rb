class FollowRequest < ActiveRecord::Base

	belongs_to :request_follower, foreign_key: "request_follower_id", class_name: "User"
  	belongs_to :request_followee, foreign_key: "request_followee_id", class_name: "User" 

end
