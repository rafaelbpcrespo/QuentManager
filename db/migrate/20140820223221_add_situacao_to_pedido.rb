class AddSituacaoToPedido < ActiveRecord::Migration
  def change
    remove_column :pedidos, :cancelado
    add_column :pedidos, :situacao, :string
  end
end
