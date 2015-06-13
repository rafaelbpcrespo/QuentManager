require 'spec_helper'
require "rspec/expectations"


describe 'Bebida' do
    before(:each) do
        @bebida = Bebida.new(:nome => "Bebida 1")
    end
    
    describe '#acrescer' do
        context 'quando a quantidade for igual de 0 (estiver DESATIVADO) e forem acrescidas 2 unidades' do
            it 'quantidade deve passar a ser igual a 2 e disponibilidade igual a TRUE' do
                @bebida.quantidade = 0
                expect(@bebida.ver_disponibilidade).to eq(false)
                @bebida.acrescer(2)
                expect(@bebida.quantidade).to eq(2)
                expect(@bebida.ver_disponibilidade).to eq(true)
            end
        end

        context 'quando a quantidade for igual de 3 (estiver ATIVADO) e forem acrescidas 5 unidades' do
            it 'quantidade deve passar a ser igual a 5 e disponibilidade igual a TRUE' do
                @bebida.quantidade = 3
                expect(@bebida.ver_disponibilidade).to eq(true)
                @bebida.acrescer(2)
                expect(@bebida.quantidade).to eq(5)
                expect(@bebida.ver_disponibilidade).to eq(true)
            end
        end
    end

    describe '#decrescer' do
        context 'quando a quantidade for igual de 0 (estiver DESATIVADO) e forem decrescidas 2 unidades' do
            it 'quantidade deve permanecer como 0 e disponibilidade igual a FALSE' do
                @bebida.quantidade = 0
                expect(@bebida.ver_disponibilidade).to eq(false)
                @bebida.decrescer(2)
                expect(@bebida.quantidade).to eq(0)
                expect(@bebida.ver_disponibilidade).to eq(false)
            end
        end

        context 'quando a quantidade for igual de 2 (estiver ATIVADO) e forem decrescidas 4 unidades' do
            it 'quantidade deve permanecer como 2 e disponibilidade igual a TRUE, pois a quantidade do pedido excede a quantidade disponível' do
                @bebida.quantidade = 2
                expect(@bebida.ver_disponibilidade).to eq(true)
                @bebida.decrescer(4)
                expect(@bebida.quantidade).to eq(2)
                expect(@bebida.ver_disponibilidade).to eq(true)
            end
        end

        context 'quando a quantidade for igual de 3 (estiver ATIVADO) e forem decrescidas 3 unidades' do
            it 'quantidade deve passar a ser igual a 0 e disponibilidade igual a FALSE' do
                @bebida.quantidade = 3
                expect(@bebida.ver_disponibilidade).to eq(true)
                @bebida.decrescer(3)
                expect(@bebida.quantidade).to eq(0)
                expect(@bebida.ver_disponibilidade).to eq(false)
            end
        end

        context 'quando a quantidade for igual de 5 (estiver ATIVADO) e forem decrescidas 3 unidades' do
            it 'quantidade deve passar a ser igual a 2 e disponibilidade igual a TRUE' do
                @bebida.quantidade = 5
                expect(@bebida.ver_disponibilidade).to eq(true)
                @bebida.decrescer(3)
                expect(@bebida.quantidade).to eq(2)
                expect(@bebida.ver_disponibilidade).to eq(true)
            end
        end
    end


    describe '#desativar' do
        context 'quando for desativado' do
            it 'quantidade deve ser igual a 0 e disponibilidade igual a FALSE' do
                @bebida.quantidade = 5
                @bebida.desativar
                expect(@bebida.quantidade).to eq(0)
                expect(@bebida.disponibilidade).to eq(false)
            end

        end
    end



    describe '#ver_disponibilidade' do
        context 'quando quantidade for diferente de 0' do
            it 'o bebida deve estar ATIVADO (disponibilidade retorna TRUE) ' do
                @bebida.quantidade = 2
                expect(@bebida.ver_disponibilidade).to eq(true)
            end
        end

        context 'quando quantidade for igual de 0' do
            it 'o bebida deve estar DESATIVADO (disponibilidade retorna FALSE)' do
                @bebida.quantidade = 0
                expect(@bebida.ver_disponibilidade).to eq(false)
            end
        end
    end
end