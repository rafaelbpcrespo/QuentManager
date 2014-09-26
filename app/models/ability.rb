class Ability
  include CanCan::Ability

  def initialize(usuario)
    # Define abilities for the passed in user here. For example:
    #
      usuario ||= Usuario.new # guest user (not logged in)
      if usuario
        if usuario.admin?
          can :manage, :all
          cannot :destroy, :all
        elsif usuario.gerente?
          can :manage, :all
          cannot :destroy, :all
          cannot :desbloquear, Cliente
        else
          cannot :manage, :all
          can [:create, :update, :read, :conta ], [Cliente], :usuario_id => usuario.id
          can [:create, :update, :read, :cancelar, :confirmar ], Pedido, :cliente_id => usuario.cliente.id
          cannot :destroy, Pedido
          #can , Pedido, :usuario_id => usuario.id
        #if (usuario.cliente.bloqueado? || usuario.empresa.bloqueada? || (Time.now.hour < 6 || DateTime.now > DateTime.now.change(hour: 10)))
         # cannot [:create, :update, :confirmar, :cancelar ], Pedido
        #end
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
