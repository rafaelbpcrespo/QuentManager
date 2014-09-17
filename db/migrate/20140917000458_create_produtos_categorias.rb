class CreateProdutosCategorias < ActiveRecord::Migration
  def change
    create_table :produtos_categorias do |t|
      t.string :nome

      t.timestamps
    end
  end
end
