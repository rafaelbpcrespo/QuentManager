require 'spec_helper'
require "rspec/expectations"


describe 'Acompanhamento' do
    before(:each) do
        @acompanhamento = Acompanhamento.new(:nome => "Acompanhamento 1")
    end
    
    describe '#acrescer' do
        context 'quando a quantidade for igual de 0 (estiver DESATIVADO) e forem acrescidas 2 unidades' do
            it 'quantidade deve passar a ser igual a 2 e disponibilidade igual a TRUE' do
                @acompanhamento.quantidade = 0
                expect(@acompanhamento.ver_disponibilidade).to eq(false)
                @acompanhamento.acrescer(2)
                expect(@acompanhamento.quantidade).to eq(2)
                expect(@acompanhamento.ver_disponibilidade).to eq(true)
            end
        end

        context 'quando a quantidade for igual de 3 (estiver ATIVADO) e forem acrescidas 5 unidades' do
            it 'quantidade deve passar a ser igual a 5 e disponibilidade igual a TRUE' do
                @acompanhamento.quantidade = 3
                expect(@acompanhamento.ver_disponibilidade).to eq(true)
                @acompanhamento.acrescer(2)
                expect(@acompanhamento.quantidade).to eq(5)
                expect(@acompanhamento.ver_disponibilidade).to eq(true)
            end
        end
    end

    describe '#decrescer' do
        context 'quando a quantidade for igual de 0 (estiver DESATIVADO) e forem decrescidas 2 unidades' do
            it 'quantidade deve permanecer como 0 e disponibilidade igual a FALSE' do
                @acompanhamento.quantidade = 0
                expect(@acompanhamento.ver_disponibilidade).to eq(false)
                @acompanhamento.decrescer(2)
                expect(@acompanhamento.quantidade).to eq(0)
                expect(@acompanhamento.ver_disponibilidade).to eq(false)
            end
        end

        context 'quando a quantidade for igual de 2 (estiver ATIVADO) e forem decrescidas 4 unidades' do
            it 'quantidade deve permanecer como 2 e disponibilidade igual a TRUE, pois a quantidade do pedido excede a quantidade disponível' do
                @acompanhamento.quantidade = 2
                expect(@acompanhamento.ver_disponibilidade).to eq(true)
                @acompanhamento.decrescer(4)
                expect(@acompanhamento.quantidade).to eq(2)
                expect(@acompanhamento.ver_disponibilidade).to eq(true)
            end
        end

        context 'quando a quantidade for igual de 3 (estiver ATIVADO) e forem decrescidas 3 unidades' do
            it 'quantidade deve passar a ser igual a 0 e disponibilidade igual a FALSE' do
                @acompanhamento.quantidade = 3
                expect(@acompanhamento.ver_disponibilidade).to eq(true)
                @acompanhamento.decrescer(3)
                expect(@acompanhamento.quantidade).to eq(0)
                expect(@acompanhamento.ver_disponibilidade).to eq(false)
            end
        end

        context 'quando a quantidade for igual de 5 (estiver ATIVADO) e forem decrescidas 3 unidades' do
            it 'quantidade deve passar a ser igual a 2 e disponibilidade igual a TRUE' do
                @acompanhamento.quantidade = 5
                expect(@acompanhamento.ver_disponibilidade).to eq(true)
                @acompanhamento.decrescer(3)
                expect(@acompanhamento.quantidade).to eq(2)
                expect(@acompanhamento.ver_disponibilidade).to eq(true)
            end
        end
    end


    describe '#desativar' do
        context 'quando for desativado' do
            it 'quantidade deve ser igual a 0 e disponibilidade igual a FALSE' do
                @acompanhamento.quantidade = 5
                @acompanhamento.desativar
                expect(@acompanhamento.quantidade).to eq(0)
                expect(@acompanhamento.disponibilidade).to eq(false)
            end

        end
    end



    describe '#ver_disponibilidade' do
        context 'quando quantidade for diferente de 0' do
            it 'o acompanhamento deve estar ATIVADO (disponibilidade retorna TRUE) ' do
                @acompanhamento.quantidade = 2
                expect(@acompanhamento.ver_disponibilidade).to eq(true)
            end
        end

        context 'quando quantidade for igual de 0' do
            it 'o acompanhamento deve estar DESATIVADO (disponibilidade retorna FALSE)' do
                @acompanhamento.quantidade = 0
                expect(@acompanhamento.ver_disponibilidade).to eq(false)
            end
        end
    end
end