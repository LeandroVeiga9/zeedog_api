class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    can :manage, User, id: user.id

    if user.is_admin
      can :manage, :all
    else
      puts user.email
      can :read, [Product, Sku]
    end
  end
end
