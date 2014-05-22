class AddCamposToProdutos < ActiveRecord::Migration
  def change
    add_column :produtos, :limite_minimo, :integer
  end
end
