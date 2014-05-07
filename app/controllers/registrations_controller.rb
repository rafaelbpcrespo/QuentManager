class RegistrationsController < Devise::RegistrationsController

  def new
    super
  end

  def create
    super
  end

  def sign_up_params
      params.require(:usuario).permit(:email, :password, :confirmation_password, :remember_me, :cliente_attributes => [ :usuario_id, :nome, :celular, :telefone, :ramal, :endereco, :complemento, :empresa, :sexo, :data_de_nascimento])
    end
end