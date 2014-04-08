class CreateItemDePedidos < ActiveRecord::Migration
  def change
    create_table :item_de_pedidos do |t|
      t.integer :produto_id
      t.integer :pedido_id
      t.integer :quantidade

      t.timestamps
    end
  end
end
