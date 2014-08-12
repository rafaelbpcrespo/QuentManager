class PedidosController < ApplicationController
  before_action :set_pedido, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  before_action :authenticate_usuario!

  # GET /pedidos
  # GET /pedidos.json
  def index
    if current_usuario.admin?
      @pedidos = Pedido.where(created_at: (Time.now.midnight)..Time.now.midnight + 1.day).paginate(:page => params[:page], :per_page => 10)
    else
      @pedidos = Pedido.where(created_at: (Time.now.midnight)..Time.now.midnight + 1.day, :cliente_id => current_usuario.cliente.id).paginate(:page => params[:page], :per_page => 10)
    end
  end

  # GET /pedidos/1
  # GET /pedidos/1.json
  def show
  end

  # GET /pedidos/new
  def new
    @cardapios_disponiveis = Cardapio.where(:disponibilidade => true, :tipo => "Carne")
    @acompanhamentos_disponiveis = Acompanhamento.where(:disponibilidade => true)
    @guarnicoes_disponiveis = Guarnicao.where(:disponibilidade => true)
    @pedido = Pedido.new
    @pedido.item_de_pedidos.build
    @pedido.pedidos_cardapios.build
    @pedido.pedidos_guarnicoes.build
    @pedido.pedidos_acompanhamentos.build
  end

  # GET /pedidos/1/edit
  def edit
    @cardapios_disponiveis = Cardapio.where(:disponibilidade => true, :tipo => "Carne")
    @pedido.cardapios.map { |cardapio| @cardapios_disponiveis << cardapio unless @cardapios_disponiveis.include? cardapio }
    @cardapios_disponiveis.sort!
    @guarnicoes_disponiveis = Guarnicao.where(:disponibilidade => true)
    @pedido.guarnicoes.map { |guarnicao| @guarnicoes_disponiveis << guarnicao unless @guarnicoes_disponiveis.include? guarnicao }
    @guarnicoes_disponiveis.sort!
    @acompanhamentos_disponiveis = Acompanhamento.where(:disponibilidade => true)
  end

  # POST /pedidos
  # POST /pedidos.json
  def create
    valor = params[:pedido][:valor]
    params[:pedido][:valor] = valor.split( ',').join('.')

    @cardapios_disponiveis = Cardapio.where(:disponibilidade => true, :tipo => "Carne")
    @acompanhamentos_disponiveis = Acompanhamento.where(:disponibilidade => true)
    @guarnicoes_disponiveis = Guarnicao.where(:disponibilidade => true)
    #descricao = ""
    @pedido = Pedido.new(pedido_params)
    if @pedido.cliente.nil?
      @pedido.cliente = Cliente.find(current_usuario.cliente.id)
    end
    # ENTRADAS #
    # acompanhamentos = params[:pedido][:acompanhamento_ids]
    # acompanhamentos.each do |id|
    #   if !id.blank?
    #     acompanhamento = Acompanhamento.find(id.to_i)
    #     @pedido.pedidos_acompanhamentos.new(:acompanhamento_id => id)
    #     #@pedido.acompanhamentos << acompanhamento
    #   end
    # end
    ###### FINAL ENTRADAS ########
    acompanhamentos = Acompanhamento.where(:disponibilidade => true).count
    for i in 0...acompanhamentos do
      if !params["acompanhamento_#{i}"].blank?
        @pedido.pedidos_acompanhamentos.new(:acompanhamento_id => params["acompanhamento_#{i}"], :quantidade => params["quantidade_acompanhamento_#{i}"])
      end
    end

    cardapios = Cardapio.where(:disponibilidade => true, :tipo => "Carne").count
    for i in 0...cardapios do
      if !params["cardapio_#{i}"].blank?
        @pedido.pedidos_cardapios.new(:cardapio_id => params["cardapio_#{i}"], :quantidade => params["quantidade_cardapio_#{i}"])
      end
    end

    guarnicoes = Guarnicao.where(:disponibilidade => true).count
    for i in 0...guarnicoes do
      if !params["guarnicao_#{i}"].blank?
        @pedido.pedidos_guarnicoes.new(:guarnicao_id => params["guarnicao_#{i}"], :quantidade => params["quantidade_guarnicao_#{i}"])
      end
    end

    #@pedido.cardapios << Cardapio.where(:nome => params[:cardapio]).first

    # debugger
    #  if !params[:arroz].nil?
    #     descricao = "Arroz "+ params[:arroz] + ","
    #   end
    #   if params[:feijao] = "Sim"
    #     descricao = descricao + " Feijao, "
    #   end

    #   if params[:farofa] == "Sim"
    #     descricao = descricao + " Farofa,"
    #   end

    # descricao = descricao + params[:cardapio] + ", " + params[:acompanhamento] + " Salada: "+ params[:salada]
    # @pedido.descricao = descricao
    itens = params[:pedido][:item_de_pedidos_attributes]

    if !itens.nil?
      for i in 0..params[:pedido][:item_de_pedidos_attributes].count do
        if itens["#{i}"] != nil
          if itens["#{i}"][:produto_id].blank?
            itens.delete("#{i}")
          end
        else
          itens.delete("#{i}")
        end
      end
    end
      if !itens.blank?
        @pedido.calcular_valor
      else
        @pedido.item_de_pedidos.destroy_all
        @pedido.valor = 0
      end
      if !itens.nil?
        params[:pedido][:item_de_pedidos_attributes].replace(itens)
      end

    #parametros[:valor] = @pedido.valor

    respond_to do |format|
      if @pedido.save
        @pedido.pedidos_cardapios.each do |pedido_cardapio|
          cardapio = pedido_cardapio.cardapio
          cardapio.decrescer(pedido_cardapio.quantidade)
        end
        @pedido.pedidos_guarnicoes.each do |pedido_guarnicao|
          guarnicao = pedido_guarnicao.guarnicao
          guarnicao.decrescer(pedido_guarnicao.quantidade)
        end
        #cardapio = @pedido.cardapio
        #cardapio.decrescer
        format.html { redirect_to @pedido, notice: 'Novo Pedido realizado com sucesso.' }
        format.json { render action: 'show', status: :created, location: @pedido }
      else
        format.html { render action: 'new' }
        format.json { render json: @pedido.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pedidos/1
  # PATCH/PUT /pedidos/1.json
  def update
    valor = params[:pedido][:valor]
    params[:pedido][:valor] = valor.split( ',').join('.')

#    descricao = ""
    pa = @pedido.pedidos_acompanhamentos
    acompanhamento_editado = []
    acompanhamento_novo = []
    acompanhamentos = Acompanhamento.where(:disponibilidade => true).count
    for i in 0...acompanhamentos do
      acompanhamento=nil
      if  !params["acompanhamento_#{i}"].blank?
        acompanhamento = Acompanhamento.find(params["acompanhamento_#{i}"])
      end
      if @pedido.acompanhamentos.include? acompanhamento
        atualiza_acompanhamento = @pedido.pedidos_acompanhamentos.find_by_acompanhamento_id(params["acompanhamento_#{i}"])
        atualiza_acompanhamento.quantidade = params["quantidade_acompanhamento_#{i}"].to_i
        acompanhamento_editado << atualiza_acompanhamento
        atualiza_acompanhamento.save
      elsif !params["acompanhamento_#{i}"].blank?
#        @pedido.pedidos_acompanhamentos.
        acompanhamento_novo << @pedido.pedidos_acompanhamentos.create!(:acompanhamento_id => params["acompanhamento_#{i}"], :quantidade => params["quantidade_acompanhamento_#{i}"])
      end
    end
      acompanhamentos_removidos = pa - acompanhamento_editado
      acompanhamentos_removidos = acompanhamentos_removidos - acompanhamento_novo
      acompanhamentos_removidos.each do |acompanhamento_removido|
        acompanhamento_removido.destroy
      end

    cardapio_novo = []
    pc = @pedido.pedidos_cardapios
    cardapio_editado = []
    cardapios = Cardapio.where(:disponibilidade => true).count
    for i in 0..cardapios do
      cardapio=nil
      if  !params["cardapio_#{i}"].blank?
        cardapio = Cardapio.find(params["cardapio_#{i}"])
      end
      if @pedido.cardapios.include? cardapio
        atualiza_cardapio = @pedido.pedidos_cardapios.find_by_cardapio_id(params["cardapio_#{i}"])
        atualiza_cardapio.quantidade = params["quantidade_cardapio_#{i}"].to_i
        cardapio_editado << atualiza_cardapio
        atualiza_cardapio.save
      elsif !params["cardapio_#{i}"].blank?
#        @pedido.pedidos_cardapios.
        cardapio_novo << @pedido.pedidos_cardapios.create!(:cardapio_id => params["cardapio_#{i}"], :quantidade => params["quantidade_cardapio_#{i}"])
        cardapio_novo.last.cardapio.decrescer(cardapio_novo.last.quantidade)
      end
    end
    #### Removendo cardapios após edição ####
    cardapios_removidos = pc - cardapio_editado
    cardapios_removidos = cardapios_removidos - cardapio_novo
    cardapios_removidos.each do |cardapio_removido|
      cardapio_removido.cardapio.acrescer(cardapio_removido.quantidade)
      #cardapio_removido.cardapio.quantidade = cardapio_removido.cardapio.quantidade + cardapio_removido.quantidade
      #cardapio = cardapio_removido.cardapio
      #cardapio.save
      cardapio_removido.destroy
    end
    ##################### Fim cardapios removidos #####################


    guarnicao_novo = []
    pc = @pedido.pedidos_guarnicoes
    guarnicao_editado = []
    guarnicoes = Guarnicao.where(:disponibilidade => true).count
    for i in 0..guarnicoes do
      guarnicao=nil
      if  !params["guarnicao_#{i}"].blank?
        guarnicao = Guarnicao.find(params["guarnicao_#{i}"])
      end
      if @pedido.guarnicoes.include? guarnicao
        atualiza_guarnicao = @pedido.pedidos_guarnicoes.find_by_guarnicao_id(params["guarnicao_#{i}"])
        atualiza_guarnicao.quantidade = params["quantidade_guarnicao_#{i}"].to_i
        guarnicao_editado << atualiza_guarnicao
        atualiza_guarnicao.save
      elsif !params["guarnicao_#{i}"].blank?
#        @pedido.pedidos_cardapios.
        guarnicao_novo << @pedido.pedidos_guarnicoes.create!(:guarnicao_id => params["guarnicao_#{i}"], :quantidade => params["quantidade_guarnicao_#{i}"])
        guarnicao_novo.last.guarnicao.decrescer(guarnicao_novo.last.quantidade)
      end
    end
    #### Removendo cardapios após edição ####
    guarnicoes_removidos = pc - guarnicao_editado
    guarnicoes_removidos = guarnicoes_removidos - guarnicao_novo
    guarnicoes_removidos.each do |guarnicao_removido|
      guarnicao_removido.guarnicao.acrescer(guarnicao_removido.quantidade)
      #cardapio_removido.cardapio.quantidade = cardapio_removido.cardapio.quantidade + cardapio_removido.quantidade
      #cardapio = cardapio_removido.cardapio
      #cardapio.save
      guarnicao_removido.destroy
    end
    ##################### Fim guarnicoes removidos #####################

    # cardapios = Cardapio.where(:disponibilidade => true, :tipo => "Carne").count
    # for i in 0...cardapios do
    #   if !params["cardapio_#{i}"].blank?
    #     @pedido.pedidos_cardapios.new(:cardapio_id => params["cardapio_#{i}"], :quantidade => params["quantidade_#{i}"])
    #   end
    # end

    parametros = pedido_params


    itens = params[:pedido][:item_de_pedidos_attributes]
    vetor_itens = params[:pedido][:item_de_pedidos_attributes].to_a
    if !itens.nil?
      for indice in 0..vetor_itens.count do
        if vetor_itens[indice] != nil
          puts "DELETAR"
          if vetor_itens[indice][1][:_destroy] == "1"
            codigo_item = vetor_itens[indice][1]
            item = ItemDePedido.find(codigo_item.to_i)
            item.destroy
            itens.delete("#{vetor_itens[indice][0]}")
          elsif vetor_itens[indice][1][:produto_id].blank?
            puts "IGNORAR"
            itens.delete("#{vetor_itens[indice][0]}")
            #itens.delete("#{i}")
          end
        end
      end
        parametros[:item_de_pedidos_attributes].replace(itens)
    end

      if !itens.blank?
        @pedido.calcular_valor
      end
#        @pedido.valor = 0 + params[:valor].to_f
 #     end
    #   if !params[:arroz].nil?
    #     descricao = "Arroz "+ params[:arroz]  + ","
    #   end
    #   if params[:feijao] = "Sim"
    #     descricao = descricao + " Feijao, "
    #   end

    #   if params[:farofa] == "Sim"
    #     descricao = descricao + " Farofa,"
    #   end

    # descricao = descricao + params[:cardapio] + ", " + params[:acompanhamento] + " Salada: "+ params[:salada]
    # @pedido.descricao = descricao
    #@pedido.calcular_valor
    
    #parametros[:valor] = @pedido.valor
    respond_to do |format|
      if @pedido.update(parametros)
        #cardapio = @pedido.cardapio
        #carne.decrescer        
        format.html { redirect_to @pedido, notice: 'Pedido atualizado com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @pedido.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pedidos/1
  # DELETE /pedidos/1.json
  def destroy
    @pedido.destroy
    respond_to do |format|
      format.html { redirect_to pedidos_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pedido
      @pedido = Pedido.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pedido_params
      params.require(:pedido).permit(:descricao, :cardapios, :acompanhamentos, :guarnicoes, :valor, :id, :cliente_id, :forma_de_pagamento, item_de_pedidos_attributes: [ :produto_id, :pedido_id, :quantidade, :_destroy, :id])
    end
end
