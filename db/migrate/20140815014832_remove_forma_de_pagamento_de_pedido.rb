class RemoveFormaDePagamentoDePedido < ActiveRecord::Migration
  def change
    remove_column :pedidos, :forma_de_pagamento
  end
end
