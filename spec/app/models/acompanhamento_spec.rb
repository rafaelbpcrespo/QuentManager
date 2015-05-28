require 'spec_helper'
require "rspec/expectations"


describe 'Acompanhamento' do
    before(:each) do
        @acompanhamento = Acompanhamento.new
    end
    
    describe '#ver_disponibilidade' do
        context 'quando quantidade for diferente de 0' do
            it 'disponibilidade retorna TRUE ' do
                @acompanhamento.quantidade = 2
                expect(@acompanhamento.ver_disponibilidade).to eq(true)
            end
        end

        context 'quando quantidade for igual de 0' do
            it 'disponibilidade retorna FALSE' do
                @acompanhamento.quantidade = 0
                expect(@acompanhamento.ver_disponibilidade).to eq(false)
            end
        end
    end
end