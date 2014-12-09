class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.belongs_to :user, index: true
      t.belongs_to :blog, index: true
      t.boolean :receive_news

      t.timestamps
    end
  end
end
