class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
    return unless user.present?

    can :manage, Post, author: user
    can :manage, Comment, author: user
    return unless user.moderator? || user.admin?

    can :update, Comment
    return unless user.admin?

    can :manage, :all
  end
end
