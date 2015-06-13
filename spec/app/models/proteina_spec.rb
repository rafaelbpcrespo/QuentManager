require 'spec_helper'
require "rspec/expectations"


describe 'Proteina' do
    before(:each) do
        @proteina = Proteina.new(:nome => "Proteina 1")
    end
    
    describe '#acrescer' do
        context 'quando a quantidade for igual de 0 (estiver DESATIVADO) e forem acrescidas 2 unidades' do
            it 'quantidade deve passar a ser igual a 2 e disponibilidade igual a TRUE' do
                @proteina.quantidade = 0
                expect(@proteina.ver_disponibilidade).to eq(false)
                @proteina.acrescer(2)
                expect(@proteina.quantidade).to eq(2)
                expect(@proteina.ver_disponibilidade).to eq(true)
            end
        end

        context 'quando a quantidade for igual de 3 (estiver ATIVADO) e forem acrescidas 5 unidades' do
            it 'quantidade deve passar a ser igual a 5 e disponibilidade igual a TRUE' do
                @proteina.quantidade = 3
                expect(@proteina.ver_disponibilidade).to eq(true)
                @proteina.acrescer(2)
                expect(@proteina.quantidade).to eq(5)
                expect(@proteina.ver_disponibilidade).to eq(true)
            end
        end
    end

    describe '#decrescer' do
        context 'quando a quantidade for igual de 0 (estiver DESATIVADO) e forem decrescidas 2 unidades' do
            it 'quantidade deve permanecer como 0 e disponibilidade igual a FALSE' do
                @proteina.quantidade = 0
                expect(@proteina.ver_disponibilidade).to eq(false)
                @proteina.decrescer(2)
                expect(@proteina.quantidade).to eq(0)
                expect(@proteina.ver_disponibilidade).to eq(false)
            end
        end

        context 'quando a quantidade for igual de 2 (estiver ATIVADO) e forem decrescidas 4 unidades' do
            it 'quantidade deve permanecer como 2 e disponibilidade igual a TRUE, pois a quantidade do pedido excede a quantidade disponível' do
                @proteina.quantidade = 2
                expect(@proteina.ver_disponibilidade).to eq(true)
                @proteina.decrescer(4)
                expect(@proteina.quantidade).to eq(2)
                expect(@proteina.ver_disponibilidade).to eq(true)
            end
        end

        context 'quando a quantidade for igual de 3 (estiver ATIVADO) e forem decrescidas 3 unidades' do
            it 'quantidade deve passar a ser igual a 0 e disponibilidade igual a FALSE' do
                @proteina.quantidade = 3
                expect(@proteina.ver_disponibilidade).to eq(true)
                @proteina.decrescer(3)
                expect(@proteina.quantidade).to eq(0)
                expect(@proteina.ver_disponibilidade).to eq(false)
            end
        end

        context 'quando a quantidade for igual de 5 (estiver ATIVADO) e forem decrescidas 3 unidades' do
            it 'quantidade deve passar a ser igual a 2 e disponibilidade igual a TRUE' do
                @proteina.quantidade = 5
                expect(@proteina.ver_disponibilidade).to eq(true)
                @proteina.decrescer(3)
                expect(@proteina.quantidade).to eq(2)
                expect(@proteina.ver_disponibilidade).to eq(true)
            end
        end
    end


    describe '#desativar' do
        context 'quando for desativado' do
            it 'quantidade deve ser igual a 0 e disponibilidade igual a FALSE' do
                @proteina.quantidade = 5
                @proteina.desativar
                expect(@proteina.quantidade).to eq(0)
                expect(@proteina.disponibilidade).to eq(false)
            end

        end
    end



    describe '#ver_disponibilidade' do
        context 'quando quantidade for diferente de 0' do
            it 'o proteina deve estar ATIVADO (disponibilidade retorna TRUE) ' do
                @proteina.quantidade = 2
                expect(@proteina.ver_disponibilidade).to eq(true)
            end
        end

        context 'quando quantidade for igual de 0' do
            it 'o proteina deve estar DESATIVADO (disponibilidade retorna FALSE)' do
                @proteina.quantidade = 0
                expect(@proteina.ver_disponibilidade).to eq(false)
            end
        end
    end
end