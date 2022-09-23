class User < ApplicationRecord
  has_many :posts
  has_many :comments
  has_many :likes

  def get_most_recent_posts(num = nil)
    recent_posts = posts.by_author(self).most_recent_ones
    num ? recent_posts.limit(num) : recent_posts
  end
end