class Usuario < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  #attr_accessible :email, :password, :password_confirmation, :remember_me, :cliente_attributes
  has_one :cliente
  accepts_nested_attributes_for :cliente
  before_create :set_tipo

  validates :email, :password, presence: true

  def set_tipo
    self.tipo = "Usuario"
  end

  def admin?
    self.tipo == "Administrador"
  end
end
