class Proteina < ActiveRecord::Base
  has_many :pedidos_proteinas
  has_many :pedidos, through: :pedidos_proteinas
#  scope :de_hoje, -> { where(created_at: (Time.now.midnight)..Time.now.midnight + 1.day).count }
  before_save :ver_disponibilidade

  validates :nome, :quantidade, :valor, presence: true
  validates :quantidade, numericality: :true
  validates :nome, uniqueness: :true

  def ver_disponibilidade
    if self.quantidade != 0
      self.disponibilidade = true
    else
      self.disponibilidade = false
      true
    end
  end

  def verificar_quantidade
    self.ver_disponibilidade
    self.save
  end

  def acrescer(quantidade_retornada)
    self.quantidade = self.quantidade + quantidade_retornada
    self.save
    self.verificar_quantidade
  end

  def decrescer(quantidade_vendida)
    self.quantidade = self.quantidade - quantidade_vendida
    self.save
    self.verificar_quantidade
  end

    def desativar
      self.disponibilidade = false
      self.quantidade = 0
    end

    def desativar!
      self.desativar
      self.save!
    end
  
end
