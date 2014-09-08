class CreatePedidosCardapios < ActiveRecord::Migration
  def change
    create_table :pedidos_cardapios do |t|
      t.integer :pedido_id
      t.integer :cardapio_id
      t.integer :quantidade

      t.timestamps
    end
  end
end
