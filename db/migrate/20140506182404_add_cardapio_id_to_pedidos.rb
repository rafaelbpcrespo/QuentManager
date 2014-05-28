class AddCardapioIdToPedidos < ActiveRecord::Migration
  def change
    add_column :pedidos, :cardapio_id, :integer
  end
end
