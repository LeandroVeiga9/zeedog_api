class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, [Product, Sku]

    return unless user.present?

    can :manage, User, id: user.id

    if user.is_admin
      can :manage, :all
    end
  end
end
