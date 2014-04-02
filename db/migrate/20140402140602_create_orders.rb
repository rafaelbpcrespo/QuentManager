class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.text :descricao
      t.float :valor
      t.integer :client_id
      t.string :forma_de_pagamento

      t.timestamps
    end
  end
end
