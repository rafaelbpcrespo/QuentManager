class AddObservacaoAndValorToCardapio < ActiveRecord::Migration
  def change
    add_column :cardapios, :valor, :decimal, :precision => 12, :scale => 2
    add_column :cardapios, :observacao, :string
  end
end
