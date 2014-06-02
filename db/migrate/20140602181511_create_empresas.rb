class CreateEmpresas < ActiveRecord::Migration
  def change
    create_table :empresas do |t|
      t.string :nome
      t.string :telefone
      t.string :endereco

      t.timestamps
    end
  end
end
