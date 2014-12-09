class Plan < ActiveRecord::Base
  has_many :user_plans
  has_many :users, through: :user_plans
end
