class CreatePedidosSaladas < ActiveRecord::Migration
  def change
    create_table :pedidos_saladas do |t|
      t.integer :pedido_id
      t.integer :salada_id
      t.integer :quantidade

      t.timestamps
    end
  end
end
