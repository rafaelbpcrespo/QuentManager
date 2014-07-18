# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140718004345) do

  create_table "arrozes", force: true do |t|
    t.string   "nome"
    t.boolean  "disponibilidade"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cardapios", force: true do |t|
    t.string   "nome"
    t.integer  "quantidade"
    t.boolean  "disponibilidade"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tipo"
    t.decimal  "valor",           precision: 12, scale: 2
    t.string   "observacao"
  end

  create_table "clientes", force: true do |t|
    t.string   "nome"
    t.string   "celular"
    t.string   "telefone"
    t.string   "ramal"
    t.string   "endereco"
    t.string   "complemento"
    t.string   "sexo"
    t.date     "data_de_nascimento"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "usuario_id"
    t.string   "setro"
    t.string   "cargo"
    t.string   "setor"
    t.string   "cpf"
    t.string   "data_de_pagamento"
    t.integer  "empresa_id"
    t.string   "rg"
    t.string   "numero"
    t.string   "bairro"
    t.string   "cidade"
    t.string   "telefone_empresa"
    t.string   "celular_empresa"
    t.string   "email_empresa"
    t.boolean  "bloqueado"
  end

  create_table "empresas", force: true do |t|
    t.string   "nome"
    t.string   "telefone"
    t.string   "endereco"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "observacao"
  end

  create_table "item_de_pedidos", force: true do |t|
    t.integer  "produto_id"
    t.integer  "pedido_id"
    t.integer  "quantidade"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pedidos", force: true do |t|
    t.text     "descricao"
    t.float    "valor"
    t.integer  "cliente_id"
    t.string   "forma_de_pagamento"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cardapio_id"
    t.integer  "arroz_id"
    t.boolean  "feijao"
    t.integer  "guarnicao_id"
    t.integer  "salada_id"
  end

  create_table "produtos", force: true do |t|
    t.string   "nome"
    t.float    "valor_unitario"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tipo"
    t.integer  "quantidade"
    t.integer  "limite_minimo"
    t.string   "categoria"
  end

  create_table "usuarios", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "tipo"
  end

  add_index "usuarios", ["confirmation_token"], name: "index_usuarios_on_confirmation_token", unique: true
  add_index "usuarios", ["email"], name: "index_usuarios_on_email", unique: true
  add_index "usuarios", ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true

end
