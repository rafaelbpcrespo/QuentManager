class AddCamposToPedidos < ActiveRecord::Migration
  def change
    add_column :pedidos, :arroz_id, :integer
    add_column :pedidos, :feijao, :boolean
    add_column :pedidos, :guarnicao_id, :integer
    add_column :pedidos, :salada_id, :integer
  end
end
