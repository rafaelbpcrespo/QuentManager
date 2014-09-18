class CreateTransacoes < ActiveRecord::Migration
  def change
    create_table :transacoes do |t|
      t.integer :produto_id
      t.decimal :valor
      t.decimal :quantidade
      t.integer :tipo

      t.timestamps
    end
  end
end
