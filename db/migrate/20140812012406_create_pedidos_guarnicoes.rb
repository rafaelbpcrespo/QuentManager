class CreatePedidosGuarnicoes < ActiveRecord::Migration
  def change
    create_table :pedidos_guarnicoes do |t|
      t.integer :pedido_id
      t.integer :guarnicao_id
      t.integer :quantidade

      t.timestamps
    end
  end
end
