class AddCanceladoToPedido < ActiveRecord::Migration
  def change
    add_column :pedidos, :cancelado, :boolean
  end
end
