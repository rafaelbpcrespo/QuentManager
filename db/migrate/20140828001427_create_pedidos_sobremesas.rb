class CreatePedidosSobremesas < ActiveRecord::Migration
  def change
    create_table :pedidos_sobremesas do |t|
      t.integer :pedido_id
      t.integer :sobremesa_id
      t.integer :quantidade

      t.timestamps
    end
  end
end
