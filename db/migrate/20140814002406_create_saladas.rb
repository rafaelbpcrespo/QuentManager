class CreateSaladas < ActiveRecord::Migration
  def change
    create_table :saladas do |t|
      t.string :nome
      t.integer :quantidade
      t.boolean :disponibilidade
      t.decimal :valor
      t.string :descricao

      t.timestamps
    end
  end
end
