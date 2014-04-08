require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  setup do
    @produto = produtos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:produtos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create produto" do
    assert_difference('Produto.count') do
      post :create, produto: { nome: @produto.nome, valor_unitario: @produto.valor_unitario }
    end

    assert_redirected_to product_path(assigns(:produto))
  end

  test "should show produto" do
    get :show, id: @produto
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @produto
    assert_response :success
  end

  test "should update produto" do
    patch :update, id: @produto, produto: { nome: @produto.nome, valor_unitario: @produto.valor_unitario }
    assert_redirected_to product_path(assigns(:produto))
  end

  test "should destroy produto" do
    assert_difference('Produto.count', -1) do
      delete :destroy, id: @produto
    end

    assert_redirected_to products_path
  end
end
