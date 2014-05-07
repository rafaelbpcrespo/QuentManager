class Pedido < ActiveRecord::Base
  belongs_to :cliente
  has_many :item_de_pedidos
  has_many :produtos, through: :item_de_pedidos
  belongs_to :carne
  accepts_nested_attributes_for :item_de_pedidos,  :allow_destroy => true

  scope :de_hoje, -> { where(created_at: (Time.now.midnight)..Time.now.midnight + 1.day).count }
end
