class Like < ActiveRecord::Base

  belongs_to :movie
  belongs_to :user

  validates :movie_id, uniqueness: { scope: [:user_id] }

end
