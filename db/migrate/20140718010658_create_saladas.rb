class CreateSaladas < ActiveRecord::Migration
  def change
    create_table :saladas do |t|
      t.string :nome
      t.boolean :disponibilidade

      t.timestamps
    end
  end
end
