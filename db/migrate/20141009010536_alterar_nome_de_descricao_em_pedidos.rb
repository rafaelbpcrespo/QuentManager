class AlterarNomeDeDescricaoEmPedidos < ActiveRecord::Migration
  def change
    rename_column :pedidos, :descricao, :observacao
  end
end
