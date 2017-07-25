class Comment < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :post

  validates :user, :body, presence: true


end
