require 'test_helper'

class CarnesControllerTest < ActionController::TestCase
  setup do
    @carne = carnes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:carnes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create carne" do
    assert_difference('Carne.count') do
      post :create, carne: { disponibilidade: @carne.disponibilidade, nome: @carne.nome, quantidade: @carne.quantidade }
    end

    assert_redirected_to carne_path(assigns(:carne))
  end

  test "should show carne" do
    get :show, id: @carne
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @carne
    assert_response :success
  end

  test "should update carne" do
    patch :update, id: @carne, carne: { disponibilidade: @carne.disponibilidade, nome: @carne.nome, quantidade: @carne.quantidade }
    assert_redirected_to carne_path(assigns(:carne))
  end

  test "should destroy carne" do
    assert_difference('Carne.count', -1) do
      delete :destroy, id: @carne
    end

    assert_redirected_to carnes_path
  end
end
