class CreateGuarnicoes < ActiveRecord::Migration
  def change
    create_table :guarnicoes do |t|
      t.string :nome
      t.boolean :disponibilidade

      t.timestamps
    end
  end
end
