class AddBlogRefToPosts < ActiveRecord::Migration
  def change
    add_reference :posts, :blog, index: true
  end
end
