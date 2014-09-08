class CreateBebidas < ActiveRecord::Migration
  def change
    create_table :bebidas do |t|
      t.string :nome
      t.integer :quantidade
      t.decimal :valor
      t.boolean :disponibilidade
      t.string :tipo

      t.timestamps
    end
  end
end
