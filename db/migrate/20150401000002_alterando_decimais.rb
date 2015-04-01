class AlterandoDecimais < ActiveRecord::Migration
  def change
    change_column :bebidas, :valor, :decimal, :precision => 10, :scale => 2
    change_column :contas, :saldo, :decimal, :precision => 10, :scale => 2
    change_column :guarnicoes, :valor, :decimal, :precision => 10, :scale => 2
    change_column :pagamentos, :valor, :decimal, :precision => 10, :scale => 2
    change_column :saladas, :valor, :decimal, :precision => 10, :scale => 2
    change_column :sobremesas, :valor, :decimal, :precision => 10, :scale => 2
    change_column :transacoes, :quantidade, :decimal, :precision => 10, :scale => 2
  end
end
