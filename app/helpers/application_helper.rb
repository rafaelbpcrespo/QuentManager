module ApplicationHelper
  def exibir_decimal(numero)
    numero_string = numero.to_s
    return numero_string.split('.').join(',')
  end
end
