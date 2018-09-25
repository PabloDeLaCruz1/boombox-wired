class AddPostLink < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :post_url, :string
  end
end
