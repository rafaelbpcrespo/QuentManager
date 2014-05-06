class AddCarneIdToPedidos < ActiveRecord::Migration
  def change
    add_column :pedidos, :carne_id, :integer
  end
end
