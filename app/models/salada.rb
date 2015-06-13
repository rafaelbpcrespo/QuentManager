class Salada < ActiveRecord::Base
  has_many :pedidos_saladas
  has_many :pedidos, through: :pedidos_saladas

  before_save :ver_disponibilidade

  validates :nome, :quantidade, :valor, presence: true
  validates :nome, uniqueness: true  

    def ver_disponibilidade
    if self.quantidade != 0
      self.disponibilidade = true
    else
      self.disponibilidade = false
      #true
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

  def acrescer_pos_cancelamento(quantidade_retornada)
    self.quantidade = self.quantidade + quantidade_retornada
    self.save
    self.verificar_quantidade
  end

  def decrescer(quantidade_vendida)
    if quantidade_vendida > self.quantidade
      return false
    end        
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

  def self.search(search)
    if search
      search = search.titleize
    end
    if search
      find(:all, :conditions => ['nome LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end


end
