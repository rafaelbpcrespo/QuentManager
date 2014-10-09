class Produto < ActiveRecord::Base
  has_many :item_de_pedidos
  has_many :pedidos, through: :item_de_pedidos
  has_many :transacoes
  belongs_to :produto_tipo
  belongs_to :produto_categoria

  validates :produto_categoria_id, :nome, :quantidade, :limite_minimo, presence: true
  validates :nome, uniqueness: true  

  scope :bebidas, -> { where(categoria: "Bebida") }
  scope :selecionaveis, -> { where(categoria: "Bebida" || "Sobremesa") }


  def atualizar(quantidade)
    self.quantidade = self.quantidade + quantidade
    self.save
  end

  def abaixo_do_limite?
    if  self.quantidade <= self.limite_minimo
      return true
    else
      return false
    end
  end

  def exibicao_select
    "#{self.nome} #{self.tipo}"
  end

  def self.em_falta
    total=0
    Produto.all.each do |p|
      if p.quantidade == 0
        total = total +1
      end
    end
      return total    
  end

  def self.em_alerta
    total=0
    Produto.all.each do |p|
      if p.abaixo_do_limite?
        total = total +1
      end
    end
      return total
  end
  
  def self.acabando
    produtos = []
    Produto.all.map { |p| produtos << p if p.abaixo_do_limite? && !(p.quantidade == 0)  }
    limite_exibicao = []
    for i in 0..2 do
      if !produtos[i].blank?
        limite_exibicao << produtos[i]
      end
    end
    return limite_exibicao
  end


  def self.acabando_completo
    produtos = []
    Produto.all.map { |p| produtos << p if p.abaixo_do_limite? && !(p.quantidade == 0) }
    return produtos
  end

  def self.zerados
    produtos = []
    Produto.all.map { |p| produtos << p if p.quantidade == 0 }
    return produtos
  end

end
