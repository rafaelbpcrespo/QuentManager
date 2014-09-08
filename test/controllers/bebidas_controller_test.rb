require 'test_helper'

class BebidasControllerTest < ActionController::TestCase
  setup do
    @bebida = bebidas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bebidas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bebida" do
    assert_difference('Bebida.count') do
      post :create, bebida: { disponibilidade: @bebida.disponibilidade, nome: @bebida.nome, quantidade: @bebida.quantidade, tipo: @bebida.tipo, valor: @bebida.valor }
    end

    assert_redirected_to bebida_path(assigns(:bebida))
  end

  test "should show bebida" do
    get :show, id: @bebida
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bebida
    assert_response :success
  end

  test "should update bebida" do
    patch :update, id: @bebida, bebida: { disponibilidade: @bebida.disponibilidade, nome: @bebida.nome, quantidade: @bebida.quantidade, tipo: @bebida.tipo, valor: @bebida.valor }
    assert_redirected_to bebida_path(assigns(:bebida))
  end

  test "should destroy bebida" do
    assert_difference('Bebida.count', -1) do
      delete :destroy, id: @bebida
    end

    assert_redirected_to bebidas_path
  end
end
