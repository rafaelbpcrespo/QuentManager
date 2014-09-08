class RenameColumnObsInProteina < ActiveRecord::Migration
  def change
    rename_column :proteinas, :observacao, :descricao
  end
end
