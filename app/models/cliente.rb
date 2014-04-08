class Cliente < ActiveRecord::Base
  has_many :pedidos
end
