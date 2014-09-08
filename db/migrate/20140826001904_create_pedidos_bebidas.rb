class CreatePedidosBebidas < ActiveRecord::Migration
  def change
    create_table :pedidos_bebidas do |t|
      t.integer :pedido_id
      t.integer :bebida_id
      t.integer :quantidade

      t.timestamps
    end
  end
end
