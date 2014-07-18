class CreateArrozes < ActiveRecord::Migration
  def change
    create_table :arrozes do |t|
      t.string :nome
      t.boolean :disponibilidade

      t.timestamps
    end
  end
end
