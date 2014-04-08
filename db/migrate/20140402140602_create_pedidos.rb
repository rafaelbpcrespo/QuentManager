class CreatePedidos < ActiveRecord::Migration
  def change
    create_table :pedidos do |t|
      t.text :descricao
      t.float :valor
      t.integer :cliente_id
      t.string :forma_de_pagamento

      t.timestamps
    end
  end
end
