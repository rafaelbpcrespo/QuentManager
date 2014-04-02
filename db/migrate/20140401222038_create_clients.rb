class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :nome
      t.string :celular
      t.string :telefone
      t.string :ramal
      t.string :endereco
      t.string :complemento
      t.string :empresa
      t.string :sexo
      t.date :data_de_nascimento

      t.timestamps
    end
  end
end
