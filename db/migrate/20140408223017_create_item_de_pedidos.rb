class CreateItemDePedidos < ActiveRecord::Migration
  def change
    create_table :item_de_pedidos do |t|
      t.integer :produtc_id
      t.integer :order_id
      t.integer :quantidade

      t.timestamps
    end
  end
end
