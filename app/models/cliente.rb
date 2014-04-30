class Cliente < ActiveRecord::Base
  has_many :pedidos
  belongs_to :usuario
end
