class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user
    if user
      user.admin? ? admin_abilities : user_abilities
    else
      guest_abilities
    end
  end

  def guest_abilities
    can :read, :all
  end

  def admin_abilities
    can :manage, :all
  end

  def user_abilities
    guest_abilities
    can :create, [Question, Answer, Comment]
    can :create, Subscription, user_id: user.id
    can :update, [Question, Answer], user_id: user.id
    can :destroy, [Question, Answer, Comment, Subscription], user_id: user.id

    can :set_best, Answer, question: { user_id: user.id  }

    can :vote, Answer do |answer|
      !user.author_of?(answer)
    end

    can :vote, Question do |question|
      !user.author_of?(question)
    end

    can :destroy, Attachment do |attachment|
      user.author_of?(attachment.attachable)
    end

    can :me, User
  end
end
