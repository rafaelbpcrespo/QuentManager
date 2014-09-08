class CreateEntradas < ActiveRecord::Migration
  def change
    create_table :entradas do |t|
      t.string :nome
      t.string :descricao
      t.boolean :disponibilidade

      t.timestamps
    end
  end
end
