class AddFieldsToClientes < ActiveRecord::Migration
  def change
    add_column :clientes, :rg, :string
    add_column :clientes, :numero, :string
    add_column :clientes, :bairro, :string
    add_column :clientes, :cidade, :string
    add_column :clientes, :telefone_empresa, :string
    add_column :clientes, :celular_empresa, :string
    add_column :clientes, :email_empresa, :string
  end
end
