class Usuario < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  #attr_accessible :email, :password, :password_confirmation, :remember_me, :cliente_attributes
  has_one :cliente
  accepts_nested_attributes_for :cliente

  validates :email, :password, :tipo, presence: true

  def admin?
    self.tipo == "Administrador"
  end
end
