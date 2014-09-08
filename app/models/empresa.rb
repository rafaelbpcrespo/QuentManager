class Empresa < ActiveRecord::Base
  has_many :clientes

  validates :nome, :telefone, :endereco, :observacao, presence: true
end
