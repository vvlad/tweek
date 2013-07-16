class Movie < ActiveRecord::Base

  serialize :genres, Array
  has_many :likes, dependent: :delete_all

  validates :title, presence: true
  validates :year, numericality: { only_integer: true}


end
