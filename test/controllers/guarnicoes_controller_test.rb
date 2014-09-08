require 'test_helper'

class GuarnicoesControllerTest < ActionController::TestCase
  setup do
    @guarnicao = guarnicoes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:guarnicoes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create guarnicao" do
    assert_difference('Guarnicao.count') do
      post :create, guarnicao: { descricao: @guarnicao.descricao, disponibilidade: @guarnicao.disponibilidade, nome: @guarnicao.nome, quantidade: @guarnicao.quantidade, valor: @guarnicao.valor }
    end

    assert_redirected_to guarnicao_path(assigns(:guarnicao))
  end

  test "should show guarnicao" do
    get :show, id: @guarnicao
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @guarnicao
    assert_response :success
  end

  test "should update guarnicao" do
    patch :update, id: @guarnicao, guarnicao: { descricao: @guarnicao.descricao, disponibilidade: @guarnicao.disponibilidade, nome: @guarnicao.nome, quantidade: @guarnicao.quantidade, valor: @guarnicao.valor }
    assert_redirected_to guarnicao_path(assigns(:guarnicao))
  end

  test "should destroy guarnicao" do
    assert_difference('Guarnicao.count', -1) do
      delete :destroy, id: @guarnicao
    end

    assert_redirected_to guarnicoes_path
  end
end
