class AddBlogIdToBlogPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :blog_posts, :blog_id, :integer
  end
end
