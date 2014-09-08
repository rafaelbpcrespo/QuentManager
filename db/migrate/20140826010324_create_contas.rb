class CreateContas < ActiveRecord::Migration
  def change
    create_table :contas do |t|
      t.integer :cliente_id
      t.decimal :saldo

      t.timestamps
    end
  end
end
