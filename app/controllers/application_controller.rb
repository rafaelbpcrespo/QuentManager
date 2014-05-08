class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery
  alias_method :current_user, :current_usuario
  load_and_authorize_resource

  def index

  end

#  @qtd_clientes = Cliente.all.count
end
