class User < ApplicationRecord
  has_many :posts, foreign_key: 'author_id'
  has_many :comments, foreign_key: 'author_id'
  has_many :likes, foreign_key: 'author_id'

  def get_most_recent_posts(num = nil)
    posts.most_recent_ones.limit(num)
  end
end
