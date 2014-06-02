class AddFieldsToCliente < ActiveRecord::Migration
  def change
    add_column :clientes, :cargo, :string
    add_column :clientes, :setor, :string
    add_column :clientes, :cpf, :string
    add_column :clientes, :data_de_pagamento, :string
  end
end
