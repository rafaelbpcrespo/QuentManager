class AdicionarCamposEmPagamento < ActiveRecord::Migration
  def change
    add_column :pagamentos, :data, :date
    add_column :pagamentos, :forma_de_pagamento, :string
  end
end
