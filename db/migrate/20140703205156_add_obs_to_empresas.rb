class AddObsToEmpresas < ActiveRecord::Migration
  def change
    add_column :empresas, :observacao, :string
  end
end
