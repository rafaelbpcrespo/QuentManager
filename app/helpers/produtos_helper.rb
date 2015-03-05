module ProdutosHelper
  def unidade_medida(produto)
    #debugger
    if ["Lata","Copo","Pet 600ml", "Pet 2l", "Unidade", "Embalagem Individual", "Garrafa 500ml", "Garrafa 1l", "Caixa", "Pacote", "Sache"].include? produto.produto_tipo.nome
      return "un"
    elsif produto.produto_tipo.nome == "Kilo"
      return "kg"
    elsif produto.produto_tipo.nome == "Grama"
      return "g"
    elsif produto.produto_tipo.nome == "Litro"
      return "l"
    end
  end
end
