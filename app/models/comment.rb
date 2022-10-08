class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  scope :by_post, ->(post_id) { where(post_id:) }
  scope :most_recent_ones, -> { order('created_at DESC') }

  after_save :increment_comments_counter
  after_destroy :decrement_comments_counter

  private

  def increment_comments_counter
    post.increment!(:comments_counter)
  end

  def decrement_comments_counter
    post.decrement!(:comments_counter) unless post.comments_counter.zero?
  end
end
