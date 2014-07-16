class Cliente < ActiveRecord::Base
  has_many :pedidos
  belongs_to :usuario
  belongs_to :empresa

  validates :nome, :empresa_id , presence: true

  def formatar_data
    data = I18n.l(self.data_de_nascimento)
  end

  def nome_abreviado
    nomes = self.nome.split
    if nomes.count > 2
      return nomes[0] + " " + nomes[1]
    end
  end

  def self.search(search,empresa)
    if search
      find(:all, :conditions => ['nome LIKE ? AND empresa_id LIKE ?', "%#{search}%", "#{empresa}"])
    else
      find(:all)
    end
  end
  # def data_de_nascimento_str=(data_de_nascimento_str)
  #   self.data_de_nascimento = self.data_de_nascimento_str
  # end
end
