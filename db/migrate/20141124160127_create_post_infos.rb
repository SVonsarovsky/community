class CreatePostInfos < ActiveRecord::Migration
  def change
    create_table :post_infos do |t|
      t.integer :post_id
      t.integer :views
      t.integer :likes
      t.integer :rating

      t.timestamps
    end
  end
end
