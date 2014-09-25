class AddFieldBloqueadaToEmpresa < ActiveRecord::Migration
  def change
    add_column :empresas, :bloqueada, :boolean
  end
end
