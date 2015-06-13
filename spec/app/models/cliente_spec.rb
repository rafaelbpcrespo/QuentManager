require 'spec_helper'
require "rspec/expectations"


describe 'Cliente' do
    before(:each) do
        @cliente = Cliente.new(:nome => "Cliente 1")
    end
    
    describe '#corrigir_nome' do
        context 'quando um cliente preenche o nome com letras minúsculas' do
            it 'o nome deve passar a ter as iniciais maiúscilas antes de ser salvo' do
                @cliente.nome = "cliente teste"
                @cliente.corrigir_nome
                expect(@cliente.nome).to eq("Cliente Teste")
            end
        end
    end

    describe '#nome_abreviado' do
        context 'quando um cliente escrever o nome com sobrenomes' do
            it 'deve exibir apenas o primeiro e o último nome' do
                @cliente.nome = "Rafael Barcellos Pessanha Crespo"
                expect(@cliente.nome_abreviado).to eq("Rafael Crespo")
            end
        end
    end

    describe '#bloquear' do
        context 'quando o Administrador bloquear um cliente' do
            it 'ele deve ter seu status como bloequado' do
                @cliente.bloquear
                expect(@cliente.bloqueado).to eq(true)
            end
        end
    end

    describe '#desbloquear' do
        context 'quando o Administrador desbloquear um cliente' do
            it 'ele deve ter seu status como desbloequado' do
                @cliente.desbloquear
                expect(@cliente.bloqueado).to eq(false)
            end
        end
    end

end