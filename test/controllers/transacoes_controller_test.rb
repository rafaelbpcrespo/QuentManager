require 'test_helper'

class TransacoesControllerTest < ActionController::TestCase
  setup do
    @transacao = transacoes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:transacoes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create transacao" do
    assert_difference('Transacao.count') do
      post :create, transacao: { produto_id: @transacao.produto_id, quantidade: @transacao.quantidade, tipo: @transacao.tipo, valor: @transacao.valor }
    end

    assert_redirected_to transacao_path(assigns(:transacao))
  end

  test "should show transacao" do
    get :show, id: @transacao
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @transacao
    assert_response :success
  end

  test "should update transacao" do
    patch :update, id: @transacao, transacao: { produto_id: @transacao.produto_id, quantidade: @transacao.quantidade, tipo: @transacao.tipo, valor: @transacao.valor }
    assert_redirected_to transacao_path(assigns(:transacao))
  end

  test "should destroy transacao" do
    assert_difference('Transacao.count', -1) do
      delete :destroy, id: @transacao
    end

    assert_redirected_to transacoes_path
  end
end
