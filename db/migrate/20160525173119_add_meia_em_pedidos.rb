class AddMeiaEmPedidos < ActiveRecord::Migration
  def change
    add_column :pedidos, :meia, :boolean, default: false
  end
end
