class Cliente < ActiveRecord::Base
  has_many :pedidos
  belongs_to :usuario
  belongs_to :empresa
  before_save :corrigir_nome

  validates :nome, :empresa_id , presence: true

  def formatar_data
    data = I18n.l(self.data_de_nascimento)
  end

  def corrigir_nome
    nome = self.nome.titleize
    self.nome = nome
  end

  def nome_abreviado
    nomes = self.nome.split
    if nomes.count > 2
      return nomes[0] + " " + nomes[1]
    else
      return self.nome
    end
  end

  def self.search(search,empresa)
    if search
      search = search.titleize
    end
    if search && !empresa.blank?
      find(:all, :conditions => ['nome LIKE ? AND empresa_id = ?', "%#{search}%", "#{empresa}"])
    elsif search
      debugger
      find(:all, :conditions => ['nome LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end

    def bloqueado?
      self[:bloqueado]
    end

    def desbloqueado?
      !self.bloqueado?
    end

    def bloquear
      self.bloqueado = true
    end

    def bloquear!
      self.bloquear
      self.save!
    end

    def desbloquear
      self.bloqueado = false
    end

    def desbloquear!
      self.desbloquear
      self.save!
    end

  # def data_de_nascimento_str=(data_de_nascimento_str)
  #   self.data_de_nascimento = self.data_de_nascimento_str
  # end
end
