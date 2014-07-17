class AddCategoriaToProdutos < ActiveRecord::Migration
  def change
    add_column :produtos, :categoria, :string
  end
end
