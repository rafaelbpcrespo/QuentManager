require 'test_helper'

class SobremesasControllerTest < ActionController::TestCase
  setup do
    @sobremesa = sobremesas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sobremesas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sobremesa" do
    assert_difference('Sobremesa.count') do
      post :create, sobremesa: { descricao: @sobremesa.descricao, disponibilidade: @sobremesa.disponibilidade, nome: @sobremesa.nome, quantidade: @sobremesa.quantidade, valor: @sobremesa.valor }
    end

    assert_redirected_to sobremesa_path(assigns(:sobremesa))
  end

  test "should show sobremesa" do
    get :show, id: @sobremesa
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sobremesa
    assert_response :success
  end

  test "should update sobremesa" do
    patch :update, id: @sobremesa, sobremesa: { descricao: @sobremesa.descricao, disponibilidade: @sobremesa.disponibilidade, nome: @sobremesa.nome, quantidade: @sobremesa.quantidade, valor: @sobremesa.valor }
    assert_redirected_to sobremesa_path(assigns(:sobremesa))
  end

  test "should destroy sobremesa" do
    assert_difference('Sobremesa.count', -1) do
      delete :destroy, id: @sobremesa
    end

    assert_redirected_to sobremesas_path
  end
end
