class AddTipoToCardapios < ActiveRecord::Migration
  def change
    add_column :cardapios, :tipo, :string
  end
end
