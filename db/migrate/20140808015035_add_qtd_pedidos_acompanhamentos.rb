class AddQtdPedidosAcompanhamentos < ActiveRecord::Migration
  def change
    add_column :pedidos_acompanhamentos, :quantidade, :integer
  end
end
