require 'spec_helper'
require "rspec/expectations"


describe 'Guarnicao' do
    before(:each) do
        @guarnicao = Guarnicao.new(:nome => "Guarnição 1")
    end
    
    describe '#acrescer' do
        context 'quando a quantidade for igual de 0 (estiver DESATIVADO) e forem acrescidas 2 unidades' do
            it 'quantidade deve passar a ser igual a 2 e disponibilidade igual a TRUE' do
                @guarnicao.quantidade = 0
                expect(@guarnicao.ver_disponibilidade).to eq(false)
                @guarnicao.acrescer(2)
                expect(@guarnicao.quantidade).to eq(2)
                expect(@guarnicao.ver_disponibilidade).to eq(true)
            end
        end

        context 'quando a quantidade for igual de 3 (estiver ATIVADO) e forem acrescidas 5 unidades' do
            it 'quantidade deve passar a ser igual a 5 e disponibilidade igual a TRUE' do
                @guarnicao.quantidade = 3
                expect(@guarnicao.ver_disponibilidade).to eq(true)
                @guarnicao.acrescer(2)
                expect(@guarnicao.quantidade).to eq(5)
                expect(@guarnicao.ver_disponibilidade).to eq(true)
            end
        end
    end

    describe '#decrescer' do
        context 'quando a quantidade for igual de 0 (estiver DESATIVADO) e forem decrescidas 2 unidades' do
            it 'quantidade deve permanecer como 0 e disponibilidade igual a FALSE' do
                @guarnicao.quantidade = 0
                expect(@guarnicao.ver_disponibilidade).to eq(false)
                @guarnicao.decrescer(2)
                expect(@guarnicao.quantidade).to eq(0)
                expect(@guarnicao.ver_disponibilidade).to eq(false)
            end
        end

        context 'quando a quantidade for igual de 2 (estiver ATIVADO) e forem decrescidas 4 unidades' do
            it 'quantidade deve permanecer como 2 e disponibilidade igual a TRUE, pois a quantidade do pedido excede a quantidade disponível' do
                @guarnicao.quantidade = 2
                expect(@guarnicao.ver_disponibilidade).to eq(true)
                @guarnicao.decrescer(4)
                expect(@guarnicao.quantidade).to eq(2)
                expect(@guarnicao.ver_disponibilidade).to eq(true)
            end
        end

        context 'quando a quantidade for igual de 3 (estiver ATIVADO) e forem decrescidas 3 unidades' do
            it 'quantidade deve passar a ser igual a 0 e disponibilidade igual a FALSE' do
                @guarnicao.quantidade = 3
                expect(@guarnicao.ver_disponibilidade).to eq(true)
                @guarnicao.decrescer(3)
                expect(@guarnicao.quantidade).to eq(0)
                expect(@guarnicao.ver_disponibilidade).to eq(false)
            end
        end

        context 'quando a quantidade for igual de 5 (estiver ATIVADO) e forem decrescidas 3 unidades' do
            it 'quantidade deve passar a ser igual a 2 e disponibilidade igual a TRUE' do
                @guarnicao.quantidade = 5
                expect(@guarnicao.ver_disponibilidade).to eq(true)
                @guarnicao.decrescer(3)
                expect(@guarnicao.quantidade).to eq(2)
                expect(@guarnicao.ver_disponibilidade).to eq(true)
            end
        end
    end


    describe '#desativar' do
        context 'quando for desativado' do
            it 'quantidade deve ser igual a 0 e disponibilidade igual a FALSE' do
                @guarnicao.quantidade = 5
                @guarnicao.desativar
                expect(@guarnicao.quantidade).to eq(0)
                expect(@guarnicao.disponibilidade).to eq(false)
            end

        end
    end



    describe '#ver_disponibilidade' do
        context 'quando quantidade for diferente de 0' do
            it 'o guarnicao deve estar ATIVADO (disponibilidade retorna TRUE) ' do
                @guarnicao.quantidade = 2
                expect(@guarnicao.ver_disponibilidade).to eq(true)
            end
        end

        context 'quando quantidade for igual de 0' do
            it 'o guarnicao deve estar DESATIVADO (disponibilidade retorna FALSE)' do
                @guarnicao.quantidade = 0
                expect(@guarnicao.ver_disponibilidade).to eq(false)
            end
        end
    end
end