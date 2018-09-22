class InitialSchema < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :password
      t.date :birthday
      t.timestamp
    end
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.references :user
      t.timestamps
    end

    create_table :post_tags do |t|
      t.references :post
      t.references :tag
      t.timestamp
    end

    create_table :tags do |t|
      t.string :title
    end
  end
end
