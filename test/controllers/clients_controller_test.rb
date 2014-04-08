require 'test_helper'

class ClientsControllerTest < ActionController::TestCase
  setup do
    @cliente = clientes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:clientes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cliente" do
    assert_difference('Cliente.count') do
      post :create, cliente: { celular: @cliente.celular, complemento: @cliente.complemento, data_de_nascimento: @cliente.data_de_nascimento, empresa: @cliente.empresa, endereco: @cliente.endereco, nome: @cliente.nome, ramal: @cliente.ramal, sexo: @cliente.sexo, telefone: @cliente.telefone }
    end

    assert_redirected_to client_path(assigns(:cliente))
  end

  test "should show cliente" do
    get :show, id: @cliente
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cliente
    assert_response :success
  end

  test "should update cliente" do
    patch :update, id: @cliente, cliente: { celular: @cliente.celular, complemento: @cliente.complemento, data_de_nascimento: @cliente.data_de_nascimento, empresa: @cliente.empresa, endereco: @cliente.endereco, nome: @cliente.nome, ramal: @cliente.ramal, sexo: @cliente.sexo, telefone: @cliente.telefone }
    assert_redirected_to client_path(assigns(:cliente))
  end

  test "should destroy cliente" do
    assert_difference('Cliente.count', -1) do
      delete :destroy, id: @cliente
    end

    assert_redirected_to clients_path
  end
end
