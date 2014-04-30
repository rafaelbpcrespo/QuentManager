class AddColumnClienteIdToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :cliente_id, :integer
  end
end
