class ProdutoTipo < ActiveRecord::Base
  has_many :produtos

  validates :nome, presence: true  
end
