class User < ActiveRecord::Base

  validates :name, presence: true
  validates :email, email: { unique: true }

  has_many :likes, dependent: :delete_all

  before_validation :normalize_email, if: :email?


  private
  def normalize_email
    self.email = email.downcase.strip
  end

end
