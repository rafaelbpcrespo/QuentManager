class Cliente < ActiveRecord::Base
  has_many :pedidos
  belongs_to :usuario

  def formatar_data
    data = I18n.l(self.data_de_nascimento)
  end

  # def data_de_nascimento_str=(data_de_nascimento_str)
  #   self.data_de_nascimento = self.data_de_nascimento_str
  # end
end
