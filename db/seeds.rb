# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

e = Empresa.new(:nome => "Spassu", :telefone => "2227723456", :endereco => "Rua Cap. Luiz Belegard, 150", :observacao => "Prédio Espelhado, próximo a Casa Luiz Belegard")
e.save!

e = Empresa.new(:nome => "Empresa1", :telefone => "2227723451", :endereco => "Rua Cap. Luiz Belegard, 150", :observacao => "Prédio Espelhado, próximo a Casa Luiz Belegard")
e.save!

e = Empresa.new(:nome => "Empresa2", :telefone => "2227723452", :endereco => "Rua Cap. Luiz Belegard, 150", :observacao => "Prédio Espelhado, próximo a Casa Luiz Belegard")
e.save!

e = Empresa.new(:nome => "Empresa3", :telefone => "2227723453", :endereco => "Rua Cap. Luiz Belegard, 150", :observacao => "Prédio Espelhado, próximo a Casa Luiz Belegard")
e.save!

e = Empresa.new(:nome => "Empresa4", :telefone => "2227723454", :endereco => "Rua Cap. Luiz Belegard, 150", :observacao => "Prédio Espelhado, próximo a Casa Luiz Belegard")
e.save!

u = Usuario.new(:email => "rafaelbpcrespo@gmail.com", :password => "123456", :tipo => "Administrador", :confirmed_at => DateTime.now)
u.cliente = Cliente.new(:nome => "Admin", :empresa_id => Empresa.first.id, :celular => "22999923456", :data_de_pagamento => "10", :cpf => "99999999999", :cargo => "Analista de Suporte", :setor => "TI", :sexo => "M", :data_de_nascimento => "17/12/1989", :telefone_empresa => "2227723456")
u.save!

u = Usuario.new(:email => "teste1@email.com", :password => "123456", :tipo => "Administrador", :confirmed_at => DateTime.now)
u.cliente = Cliente.new(:nome => "Teste 1", :empresa_id => Empresa.first.id, :celular => "22999923458", :data_de_pagamento => "10", :cpf => "99999999999", :cargo => "Analista de Suporte", :setor => "TI", :sexo => "M", :data_de_nascimento => "17/12/1989", :telefone_empresa => "2227723456")
u.save!

u = Usuario.new(:email => "teste2@email.com", :password => "123456", :tipo => "Administrador", :confirmed_at => DateTime.now)
u.cliente = Cliente.new(:nome => "Teste 2", :empresa_id => Empresa.first.id, :celular => "22999923458", :data_de_pagamento => "10", :cpf => "99999999999", :cargo => "Analista de Suporte", :setor => "TI", :sexo => "M", :data_de_nascimento => "17/12/1989", :telefone_empresa => "2227723456")
u.save!

["Rocambole", "Frango Grelhado", "Medalhão de Frango", "Almôndegas"].each do |nome|
  p = Proteina.new(:nome => nome, :quantidade => 5, :valor => "2,50", :descricao => "Descrição #{nome}")
  p.save!
end

["Empadão de Frango", "Escondidinho de Camarão", "Purê de Batatas"].each do |nome|
  g = Guarnicao.new(:nome => nome, :quantidade => 5, :valor => "1,50", :descricao => "Descrição #{nome}")
  g.save!
end

["Tabule", "Macarronesa", "Salada Marroquina"].each do |nome|
  s = Salada.new(:nome => nome, :quantidade => 5, :valor => "1,50", :descricao => "Descrição #{nome}")
  s.save!
end

["Doce de Leite", "Goiabada", "Gelatina"].each do |nome|
  s = Sobremesa.new(:nome => nome, :quantidade => 5, :valor => "1,50", :descricao => "Descrição #{nome}")
  s.save!
end

["Guaravita", "Coca Cola", "Guaraná", "H2O"].each do |nome|
  b = Bebida.new(:nome => nome, :quantidade => 5, :valor => "1,50", :tipo => "Lata")
  b.save!
end

["Arroz Branco", "Feijão", "Farofa"].each do |nome|
  a = Acompanhamento.new(:nome => nome, :descricao => "Descrição #{nome}", :disponibilidade => true)
  a.save!
end
