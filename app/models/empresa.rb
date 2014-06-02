class Empresa < ActiveRecord::Base
  has_many :clientes
end
