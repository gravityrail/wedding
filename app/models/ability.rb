class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    
    can [ :home ], :pages
    
    if user.role == 'admin'
      can :manage, :pages
      can :manage, User
      can :manage, Event
      can :view, 'audit_trail'
    end
  end
end
