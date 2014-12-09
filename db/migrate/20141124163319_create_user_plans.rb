class CreateUserPlans < ActiveRecord::Migration
  def change
    create_table :user_plans do |t|
      t.belongs_to :user, index: true
      t.belongs_to :plan, index: true

      t.timestamps
    end
  end
end
