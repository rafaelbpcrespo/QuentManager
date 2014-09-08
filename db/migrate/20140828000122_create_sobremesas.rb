class CreateSobremesas < ActiveRecord::Migration
  def change
    create_table :sobremesas do |t|
      t.string :nome
      t.integer :quantidade
      t.decimal :valor
      t.boolean :disponibilidade
      t.string :descricao

      t.timestamps
    end
  end
end
