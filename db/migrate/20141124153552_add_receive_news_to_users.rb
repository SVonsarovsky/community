class AddReceiveNewsToUsers < ActiveRecord::Migration
  #def change
  #  add_column :users, :receive_news, :boolean
  #end
  def up
    change_table :users do |t|
      t.boolean :receive_news, default: true
      t.index :receive_news
    end
    User.update_all ['receive_news = ?', true]
  end
  def down
    remove_column :users, :receive_news
  end
end
