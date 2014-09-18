class ChangeQtdTipoEmProdutos < ActiveRecord::Migration
  def change
    change_column :produtos, :quantidade, :decimal, precision: 5, scale: 2
  end
end
