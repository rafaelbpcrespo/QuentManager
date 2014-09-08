class CreatePedidosEntradas < ActiveRecord::Migration
  def change
    create_table :pedidos_entradas do |t|
      t.integer :entrada_id
      t.integer :pedido_id

      t.timestamps
    end
  end
end
