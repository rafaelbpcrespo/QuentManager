class CreateProdutosTipos < ActiveRecord::Migration
  def change
    create_table :produtos_tipos do |t|
      t.string :nome

      t.timestamps
    end
  end
end
