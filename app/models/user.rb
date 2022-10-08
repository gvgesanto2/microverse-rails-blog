class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :posts, foreign_key: 'author_id', dependent: :destroy
  has_many :comments, foreign_key: 'author_id', dependent: :destroy
  has_many :likes, foreign_key: 'author_id', dependent: :destroy

  enum role: %i[user moderator admin]

  after_initialize :set_default_role, if: :new_record?

  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def get_most_recent_posts(num = nil)
    posts.most_recent_ones.limit(num)
  end

  def is?(role)
    self.role == role.to_s
  end

  def moderator?
    is? :moderator
  end

  def admin?
    is? :admin
  end

  def require_role(*roles)
    roles.include? role.to_sym
  end

  private

  def set_default_role
    self.role ||= :user
  end
end
