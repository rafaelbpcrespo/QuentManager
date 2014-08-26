class AddContaIdToPedidos < ActiveRecord::Migration
  def change
    add_column :pedidos, :conta_id, :integer
  end
end
