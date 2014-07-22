class Entrada < ActiveRecord::Base
  has_many :pedidos_entradas
  has_many :pedidos, through: :pedidos_entradas
end
