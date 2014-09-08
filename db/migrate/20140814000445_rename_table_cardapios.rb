class RenameTableCardapios < ActiveRecord::Migration
  def change
    rename_table :cardapios, :proteinas
    rename_table :pedidos_cardapios, :pedidos_proteinas
    rename_column :pedidos_proteinas, :cardapio_id, :proteina_id
  end
end
