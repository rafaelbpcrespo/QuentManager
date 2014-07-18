class PedidosController < ApplicationController
  before_action :set_pedido, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  before_action :authenticate_usuario!

  # GET /pedidos
  # GET /pedidos.json
  def index
    if current_usuario.admin?
      @pedidos = Pedido.where(created_at: (Time.now.midnight)..Time.now.midnight + 1.day).paginate(:page => params[:page], :per_page => 1)
    else
      @pedidos = Pedido.where(created_at: (Time.now.midnight)..Time.now.midnight + 1.day, :cliente_id => current_usuario.cliente.id).paginate(:page => params[:page], :per_page => 1)
    end
  end

  # GET /pedidos/1
  # GET /pedidos/1.json
  def show
  end

  # GET /pedidos/new
  def new
    @carnes_disponiveis = Cardapio.where(:disponibilidade => true, :tipo => "Carne")
    @pedido = Pedido.new
    @pedido.item_de_pedidos.build
  end

  # GET /pedidos/1/edit
  def edit
    @carnes_disponiveis = Cardapio.where(:disponibilidade => true, :tipo => "Carne")
  end

  # POST /pedidos
  # POST /pedidos.json
  def create
    #descricao = ""
    @pedido = Pedido.new(pedido_params)
    if @pedido.cliente.nil?
      @pedido.cliente = Cliente.find(current_usuario.cliente.id)
    end
    
    @pedido.cardapio = Cardapio.where(:nome => params[:carne]).first
      # if !params[:arroz].nil?
      #   descricao = "Arroz "+ params[:arroz] + ","
      # end
      # if params[:feijao] = "Sim"
      #   descricao = descricao + " Feijao, "
      # end

      # if params[:farofa] == "Sim"
      #   descricao = descricao + " Farofa,"
      # end

#    descricao = descricao + params[:cardapio] + ", " + params[:acompanhamento] + " Salada: "+ params[:salada]
    #@pedido.descricao = 
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
      params[:pedido][:item_de_pedidos_attributes].replace(itens)

    #parametros[:valor] = @pedido.valor


    respond_to do |format|
      if @pedido.save
        cardapio = @pedido.cardapio
        cardapio.decrescer
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
    descricao = ""
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
      else
        @pedido.valor = 0
      end
      if !params[:arroz].nil?
        descricao = "Arroz "+ params[:arroz]  + ","
      end
      if params[:feijao] = "Sim"
        descricao = descricao + " Feijao, "
      end

      if params[:farofa] == "Sim"
        descricao = descricao + " Farofa,"
      end

    descricao = descricao + params[:cardapio] + ", " + params[:acompanhamento] + " Salada: "+ params[:salada]
    @pedido.descricao = descricao
    #@pedido.calcular_valor
    parametros[:valor] = @pedido.valor
    respond_to do |format|
      if @pedido.update(parametros)
        cardapio = @pedido.cardapio
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
      params.require(:pedido).permit(:descricao, :valor, :id, :cliente_id, :forma_de_pagamento, item_de_pedidos_attributes: [ :produto_id, :pedido_id, :quantidade, :_destroy, :id])
    end
end
