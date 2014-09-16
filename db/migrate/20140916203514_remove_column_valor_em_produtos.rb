class RemoveColumnValorEmProdutos < ActiveRecord::Migration
  def change
    remove_column :produtos, :valor_unitario
    remove_column :transacoes, :valor
  end
end
