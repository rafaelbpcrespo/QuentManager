class RemoveTipoDeProteinas < ActiveRecord::Migration
  def change
    remove_column :proteinas, :tipo
  end
end
