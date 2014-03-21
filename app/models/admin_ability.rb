class AdminAbility
  include CanCan::Ability
  def initialize(user)
    if user.has_role? :superadmin
      can :access, :rails_admin
      can :manage, :all   
    end
  end
end
