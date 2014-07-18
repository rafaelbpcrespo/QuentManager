require 'test_helper'

class SaladasControllerTest < ActionController::TestCase
  setup do
    @salada = saladas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:saladas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create salada" do
    assert_difference('Salada.count') do
      post :create, salada: { disponibilidade: @salada.disponibilidade, nome: @salada.nome }
    end

    assert_redirected_to salada_path(assigns(:salada))
  end

  test "should show salada" do
    get :show, id: @salada
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @salada
    assert_response :success
  end

  test "should update salada" do
    patch :update, id: @salada, salada: { disponibilidade: @salada.disponibilidade, nome: @salada.nome }
    assert_redirected_to salada_path(assigns(:salada))
  end

  test "should destroy salada" do
    assert_difference('Salada.count', -1) do
      delete :destroy, id: @salada
    end

    assert_redirected_to saladas_path
  end
end
