require 'spec_helper'
require "rspec/expectations"


describe 'Salada' do
    before(:each) do
        @salada = Salada.new(:nome => "Salada 1")
    end
    
    describe '#acrescer' do
        context 'quando a quantidade for igual de 0 (estiver DESATIVADO) e forem acrescidas 2 unidades' do
            it 'quantidade deve passar a ser igual a 2 e disponibilidade igual a TRUE' do
                @salada.quantidade = 0
                expect(@salada.ver_disponibilidade).to eq(false)
                @salada.acrescer(2)
                expect(@salada.quantidade).to eq(2)
                expect(@salada.ver_disponibilidade).to eq(true)
            end
        end

        context 'quando a quantidade for igual de 3 (estiver ATIVADO) e forem acrescidas 5 unidades' do
            it 'quantidade deve passar a ser igual a 5 e disponibilidade igual a TRUE' do
                @salada.quantidade = 3
                expect(@salada.ver_disponibilidade).to eq(true)
                @salada.acrescer(2)
                expect(@salada.quantidade).to eq(5)
                expect(@salada.ver_disponibilidade).to eq(true)
            end
        end
    end

    describe '#decrescer' do
        context 'quando a quantidade for igual de 0 (estiver DESATIVADO) e forem decrescidas 2 unidades' do
            it 'quantidade deve permanecer como 0 e disponibilidade igual a FALSE' do
                @salada.quantidade = 0
                expect(@salada.ver_disponibilidade).to eq(false)
                @salada.decrescer(2)
                expect(@salada.quantidade).to eq(0)
                expect(@salada.ver_disponibilidade).to eq(false)
            end
        end

        context 'quando a quantidade for igual de 2 (estiver ATIVADO) e forem decrescidas 4 unidades' do
            it 'quantidade deve permanecer como 2 e disponibilidade igual a TRUE, pois a quantidade do pedido excede a quantidade disponível' do
                @salada.quantidade = 2
                expect(@salada.ver_disponibilidade).to eq(true)
                @salada.decrescer(4)
                expect(@salada.quantidade).to eq(2)
                expect(@salada.ver_disponibilidade).to eq(true)
            end
        end

        context 'quando a quantidade for igual de 3 (estiver ATIVADO) e forem decrescidas 3 unidades' do
            it 'quantidade deve passar a ser igual a 0 e disponibilidade igual a FALSE' do
                @salada.quantidade = 3
                expect(@salada.ver_disponibilidade).to eq(true)
                @salada.decrescer(3)
                expect(@salada.quantidade).to eq(0)
                expect(@salada.ver_disponibilidade).to eq(false)
            end
        end

        context 'quando a quantidade for igual de 5 (estiver ATIVADO) e forem decrescidas 3 unidades' do
            it 'quantidade deve passar a ser igual a 2 e disponibilidade igual a TRUE' do
                @salada.quantidade = 5
                expect(@salada.ver_disponibilidade).to eq(true)
                @salada.decrescer(3)
                expect(@salada.quantidade).to eq(2)
                expect(@salada.ver_disponibilidade).to eq(true)
            end
        end
    end


    describe '#desativar' do
        context 'quando for desativado' do
            it 'quantidade deve ser igual a 0 e disponibilidade igual a FALSE' do
                @salada.quantidade = 5
                @salada.desativar
                expect(@salada.quantidade).to eq(0)
                expect(@salada.disponibilidade).to eq(false)
            end

        end
    end



    describe '#ver_disponibilidade' do
        context 'quando quantidade for diferente de 0' do
            it 'o salada deve estar ATIVADO (disponibilidade retorna TRUE) ' do
                @salada.quantidade = 2
                expect(@salada.ver_disponibilidade).to eq(true)
            end
        end

        context 'quando quantidade for igual de 0' do
            it 'o salada deve estar DESATIVADO (disponibilidade retorna FALSE)' do
                @salada.quantidade = 0
                expect(@salada.ver_disponibilidade).to eq(false)
            end
        end
    end
end