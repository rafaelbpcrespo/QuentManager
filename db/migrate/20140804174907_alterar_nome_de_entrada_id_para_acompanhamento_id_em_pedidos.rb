class AlterarNomeDeEntradaIdParaAcompanhamentoIdEmPedidos < ActiveRecord::Migration
  def change
    rename_table :pedidos_entradas, :pedidos_acompanhamentos
    rename_column :pedidos_acompanhamentos, :entrada_id, :acompanhamento_id
  end
end
