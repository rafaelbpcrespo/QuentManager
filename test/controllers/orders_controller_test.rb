require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  setup do
    @pedido = pedidos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pedidos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pedido" do
    assert_difference('Pedido.count') do
      post :create, pedido: { client_id: @pedido.client_id, descricao: @pedido.descricao, forma_de_pagamento: @pedido.forma_de_pagamento, valor: @pedido.valor }
    end

    assert_redirected_to order_path(assigns(:pedido))
  end

  test "should show pedido" do
    get :show, id: @pedido
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pedido
    assert_response :success
  end

  test "should update pedido" do
    patch :update, id: @pedido, pedido: { client_id: @pedido.client_id, descricao: @pedido.descricao, forma_de_pagamento: @pedido.forma_de_pagamento, valor: @pedido.valor }
    assert_redirected_to order_path(assigns(:pedido))
  end

  test "should destroy pedido" do
    assert_difference('Pedido.count', -1) do
      delete :destroy, id: @pedido
    end

    assert_redirected_to orders_path
  end
end
