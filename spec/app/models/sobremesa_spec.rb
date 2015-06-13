require 'spec_helper'
require "rspec/expectations"


describe 'Sobremesa' do
    before(:each) do
        @sobremesa = Sobremesa.new(:nome => "Sobremesa 1")
    end
    
    describe '#acrescer' do
        context 'quando a quantidade for igual de 0 (estiver DESATIVADO) e forem acrescidas 2 unidades' do
            it 'quantidade deve passar a ser igual a 2 e disponibilidade igual a TRUE' do
                @sobremesa.quantidade = 0
                expect(@sobremesa.ver_disponibilidade).to eq(false)
                @sobremesa.acrescer(2)
                expect(@sobremesa.quantidade).to eq(2)
                expect(@sobremesa.ver_disponibilidade).to eq(true)
            end
        end

        context 'quando a quantidade for igual de 3 (estiver ATIVADO) e forem acrescidas 5 unidades' do
            it 'quantidade deve passar a ser igual a 5 e disponibilidade igual a TRUE' do
                @sobremesa.quantidade = 3
                expect(@sobremesa.ver_disponibilidade).to eq(true)
                @sobremesa.acrescer(2)
                expect(@sobremesa.quantidade).to eq(5)
                expect(@sobremesa.ver_disponibilidade).to eq(true)
            end
        end
    end

    describe '#decrescer' do
        context 'quando a quantidade for igual de 0 (estiver DESATIVADO) e forem decrescidas 2 unidades' do
            it 'quantidade deve permanecer como 0 e disponibilidade igual a FALSE' do
                @sobremesa.quantidade = 0
                expect(@sobremesa.ver_disponibilidade).to eq(false)
                @sobremesa.decrescer(2)
                expect(@sobremesa.quantidade).to eq(0)
                expect(@sobremesa.ver_disponibilidade).to eq(false)
            end
        end

        context 'quando a quantidade for igual de 2 (estiver ATIVADO) e forem decrescidas 4 unidades' do
            it 'quantidade deve permanecer como 2 e disponibilidade igual a TRUE, pois a quantidade do pedido excede a quantidade disponível' do
                @sobremesa.quantidade = 2
                expect(@sobremesa.ver_disponibilidade).to eq(true)
                @sobremesa.decrescer(4)
                expect(@sobremesa.quantidade).to eq(2)
                expect(@sobremesa.ver_disponibilidade).to eq(true)
            end
        end

        context 'quando a quantidade for igual de 3 (estiver ATIVADO) e forem decrescidas 3 unidades' do
            it 'quantidade deve passar a ser igual a 0 e disponibilidade igual a FALSE' do
                @sobremesa.quantidade = 3
                expect(@sobremesa.ver_disponibilidade).to eq(true)
                @sobremesa.decrescer(3)
                expect(@sobremesa.quantidade).to eq(0)
                expect(@sobremesa.ver_disponibilidade).to eq(false)
            end
        end

        context 'quando a quantidade for igual de 5 (estiver ATIVADO) e forem decrescidas 3 unidades' do
            it 'quantidade deve passar a ser igual a 2 e disponibilidade igual a TRUE' do
                @sobremesa.quantidade = 5
                expect(@sobremesa.ver_disponibilidade).to eq(true)
                @sobremesa.decrescer(3)
                expect(@sobremesa.quantidade).to eq(2)
                expect(@sobremesa.ver_disponibilidade).to eq(true)
            end
        end
    end


    describe '#desativar' do
        context 'quando for desativado' do
            it 'quantidade deve ser igual a 0 e disponibilidade igual a FALSE' do
                @sobremesa.quantidade = 5
                @sobremesa.desativar
                expect(@sobremesa.quantidade).to eq(0)
                expect(@sobremesa.disponibilidade).to eq(false)
            end

        end
    end



    describe '#ver_disponibilidade' do
        context 'quando quantidade for diferente de 0' do
            it 'o sobremesa deve estar ATIVADO (disponibilidade retorna TRUE) ' do
                @sobremesa.quantidade = 2
                expect(@sobremesa.ver_disponibilidade).to eq(true)
            end
        end

        context 'quando quantidade for igual de 0' do
            it 'o sobremesa deve estar DESATIVADO (disponibilidade retorna FALSE)' do
                @sobremesa.quantidade = 0
                expect(@sobremesa.ver_disponibilidade).to eq(false)
            end
        end
    end
end