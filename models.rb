require "sinatra/activerecord"
require "pg"

configure :development do
  set :database, "postgresql:rumbler"
end
puts "-----------------------------------------"
puts ENV["DATABASE_URL"]
configure :production do
  # this environment variable is auto generated/set by heroku
  #   check Settings > Reveal Config Vars on your heroku app admin panel
  set :database, ENV["DATABASE_URL"]
end

class User < ActiveRecord::Base
  has_many :posts, :dependent => :destroy
end

class Post < ActiveRecord::Base
  belongs_to :user
  has_many :tags, through: :post_tags

  def title_and_content
    "#{self.title}, #{self.content}"
  end
end

class PostTag < ActiveRecord::Base
  belongs_to :post
  belongs_to :tag
end

class Tag < ActiveRecord::Base
  has_many :posts, through: :post_tags
end
