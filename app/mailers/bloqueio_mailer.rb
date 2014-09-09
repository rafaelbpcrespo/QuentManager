class BloqueioMailer < ActionMailer::Base
  default from: "pedidossiquitutes@gmail.com"

  def bloquear(usuario)
    mail(:to => usuario.email, :subject => "Conta Si Quitutes Bloqueada")
  end
end
