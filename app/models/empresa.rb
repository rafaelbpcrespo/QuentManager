class Empresa < ActiveRecord::Base
  has_many :clientes

  validates :nome, :telefone, :endereco, :observacao, presence: true

    def bloqueada?
      self[:bloqueada]
    end

    def desbloqueada?
      !self.bloqueada?
    end

    def bloquear
      self.bloqueada = true
      self.clientes.each do |cliente|
        cliente.bloquear!
      end
    end

    def bloquear!
      self.bloquear
      self.save!
    end

    def desbloquear
      self.bloqueada = false
    end

    def desbloquear!
      self.desbloquear
      self.save!
    end

end
