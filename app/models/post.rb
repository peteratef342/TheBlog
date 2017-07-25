class Post < ActiveRecord::Base

	belongs_to :user
	validates :title, :user, :body, presence: true

	has_many :comments, dependent: :destroy       
	has_many :likes, 	dependent: :destroy 
	has_many :likers , through:  :likes ,  source: :user
	has_many :tags, 	dependent: :destroy 
	has_many :users , through:  :tags 	
	belongs_to  :parent_post , class_name: "Post"
	
	enum privacy: {private_post: 1, public_post: 2}

	accepts_nested_attributes_for :tags
	

end
