class CreateCarnes < ActiveRecord::Migration
  def change
    create_table :carnes do |t|
      t.string :nome
      t.integer :quantidade
      t.boolean :disponibilidade

      t.timestamps
    end
  end
end
