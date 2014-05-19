class AddTipoToProdutos < ActiveRecord::Migration
  def change
    add_column :produtos, :tipo, :string
    add_column :produtos, :quantidade, :integer
  end
end
