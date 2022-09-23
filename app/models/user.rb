class User < ApplicationRecord
  has_many :posts, foreign_key: 'author_id'
  has_many :comments, foreign_key: 'author_id'
  has_many :likes, foreign_key: 'author_id'

  def get_most_recent_posts(num = nil)
    recent_posts = posts.most_recent_ones
    num ? recent_posts.limit(num) : recent_posts
  end
end
