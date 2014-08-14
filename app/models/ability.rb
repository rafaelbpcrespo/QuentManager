class Ability
  include CanCan::Ability

  def initialize(usuario)
    # Define abilities for the passed in user here. For example:
    #
      usuario ||= Usuario.new # guest user (not logged in)
      if usuario
        if usuario.admin?
          can :manage, :all
        else
          can [:create, :update, :read ], [Cliente], :usuario_id => usuario.id
          can [:create, :update, :read ], Pedido, :cliente_id => usuario.id
          cannot :destroy, Pedido
          #can , Pedido, :usuario_id => usuario.id
        if usuario.cliente.bloqueado?
          cannot [:create, :update, :read ], Pedido, :cliente_id => usuario.id
        end
        end
      else

      cannot [:destroy], Pedido

      end
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
    # https://github.com/bryanrite/cancancan/wiki/Defining-Abilities
  end
end
