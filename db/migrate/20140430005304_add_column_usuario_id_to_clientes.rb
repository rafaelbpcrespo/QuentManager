class AddColumnUsuarioIdToClientes < ActiveRecord::Migration
  def change
    add_column :clientes, :usuario_id, :integer
  end
end
