class CreateClientes < ActiveRecord::Migration
  def change
    create_table :clientes do |t|
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
