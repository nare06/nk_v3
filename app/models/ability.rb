class Ability
  include CanCan::Ability
  def initialize(user)
    # Define abilities for the passed in user here. For example:      
        # guest user (not logged in)
        user = user || User.new
       #if user.role? :super_admin
      # can :read, :all     
            if user.has_role? :superadmin
                can :access, :rails_admin
                 can :dashboard 
                 can :manage, :all                           
             elsif user.has_role? :halladmin 
                  can :read, :all  
                  can :access, :rails_admin
                 can :dashboard 
                  can :manage, Event, :reach_id => 1
                  can :manage, User, :id => user.id
                  can :create, [Category, Domain, Eligible]
                  can [:index,:update], :admin
                  cannot :export, :all
                  cannot :history, :all
                  cannot :read, [Authorization, Event, User]
                elsif user.role == "user"
                  can :read, :all  
                  can :access, :rails_admin
                 can :dashboard 
                  can :manage, Event, :user_id => user.id
                  can :manage, User, :id => user.id
                  can :create, [Category, Domain, Eligible]
                  can :index, :admin
                  cannot :export, :all
                  cannot :history, :all
                  cannot :read, [Authorization, Event, User] 
                elsif user.role == "guest"
                  can :read, :all
                end 

 
      # else
       #  can :read, :all 
      # end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
