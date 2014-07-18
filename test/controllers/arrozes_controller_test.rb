require 'test_helper'

class ArrozesControllerTest < ActionController::TestCase
  setup do
    @arroz = arrozes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:arrozes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create arroz" do
    assert_difference('Arroz.count') do
      post :create, arroz: { disponibilidade: @arroz.disponibilidade, nome: @arroz.nome }
    end

    assert_redirected_to arroz_path(assigns(:arroz))
  end

  test "should show arroz" do
    get :show, id: @arroz
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @arroz
    assert_response :success
  end

  test "should update arroz" do
    patch :update, id: @arroz, arroz: { disponibilidade: @arroz.disponibilidade, nome: @arroz.nome }
    assert_redirected_to arroz_path(assigns(:arroz))
  end

  test "should destroy arroz" do
    assert_difference('Arroz.count', -1) do
      delete :destroy, id: @arroz
    end

    assert_redirected_to arrozes_path
  end
end
