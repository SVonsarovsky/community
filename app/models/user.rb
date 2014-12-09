class User < ActiveRecord::Base
  has_many :posts
  has_many :subscriptions
  has_many :blogs, through: :subscriptions
  has_one :user_plan
  has_one :plan, through: :user_plan
  has_one :picture, as: :imageable

  validates :email, :first_name, presence: true
  validates :email, uniqueness: true

  scope :admins, -> { where(admin: true) }
  after_update :email_changed, if: :email_changed?

  private

  def email_changed
    UserMailer.email_changed(self).deliver
  end
end
