# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

e = Empresa.new(:nome => "Spassu", :telefone => "2227723456", :endereco => "Rua Cap. Luiz Belegard, 150", :observacao => "Prédio Espelhado, próximo a Casa Luiz Belegard")
e.save!

u = Usuario.new(:email => "rafaelbpcrespo@gmail.com", :password => "123456", :tipo => "Administrador", :confirmed_at => DateTime.now)
u.cliente = Cliente.new(:nome => "Admin", :empresa_id => Empresa.first.id, :celular => "22999923456", :data_de_pagamento => "10", :cpf => "99999999999", :cargo => "Analista de Suporte", :setor => "TI", :sexo => "M", :data_de_nascimento => "17/12/1989", :telefone_empresa => "2227723456")
u.save!

