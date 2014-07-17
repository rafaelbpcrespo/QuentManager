class AdicionarBloqueadoEmClientes < ActiveRecord::Migration
  def change
    add_column :clientes, :bloqueado, :boolean
  end
end
