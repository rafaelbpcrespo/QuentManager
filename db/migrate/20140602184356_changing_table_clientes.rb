class ChangingTableClientes < ActiveRecord::Migration
  def change
    remove_column :clientes, :empresa, :string
    add_column :clientes, :empresa_id, :integer
  end
end
