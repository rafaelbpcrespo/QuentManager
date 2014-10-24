class PedidoMailer < ActionMailer::Base
  default from: "contato@siquitutes.com"

  def confirmar_pedido(usuario,pedido)
    @usuario = usuario
    @pedido = pedido
    mail(:to => usuario.email, :subject => "Pedido Confirmado - Si Quitutes")
  end
end
