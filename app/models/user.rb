class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :username, presence: true, uniqueness: true
  
  has_many :posts, dependent: :destroy       
  has_many :comments, dependent: :destroy       
  has_many :likes, dependent: :destroy       
  # follower_follows "names" the Follow join table for accessing through the follower association
  has_many :follower_follows, foreign_key: :followee_id, class_name: "UserFollower" 
  # source: :follower matches with the belong_to :follower identification in the Follow model 
  has_many :followers, through: :follower_follows, source: :follower

  # followee_follows "names" the Follow join table for accessing through the followee association
  has_many :followee_follows, foreign_key: :follower_id, class_name: "UserFollower"    
  # source: :followee matches with the belong_to :followee identification in the Follow model   
  has_many :followees, through: :followee_follows, source: :followee


  has_many :follower_request_relation, foreign_key: :request_follower_id, class_name: "FollowRequest" 
  has_many :follower_requests, through: :follower_request_relation, source: :request_follower , dependent: :destroy
 
  has_many :followee_request_relation, foreign_key: :request_followee_id, class_name: "FollowRequest" 
  has_many :followee_requests, through: :followee_request_relation, source: :request_followee , dependent: :destroy
 


end
