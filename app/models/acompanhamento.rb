class Acompanhamento < ActiveRecord::Base
  has_many :pedidos_acompanhamentos
  has_many :pedidos, through: :pedidos_acompanhamentos
end