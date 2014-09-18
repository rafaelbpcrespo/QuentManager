class AddFieldsToProduto < ActiveRecord::Migration
  def change
    add_column :produtos, :produto_categoria_id, :integer
    add_column :produtos, :produto_tipo_id, :integer
  end
end