class PedidosController < ApplicationController
  before_action :set_pedido, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  before_action :authenticate_usuario!

  # GET /pedidos
  # GET /pedidos.json
  def index
    if current_usuario.admin?
      @pedidos = Pedido.where(created_at: (Time.now.midnight)..Time.now.midnight + 1.day)
    else
      @pedidos = Pedido.where(created_at: (Time.now.midnight)..Time.now.midnight + 1.day, :cliente_id => current_usuario.cliente.id)
    end
  end

  # GET /pedidos/1
  # GET /pedidos/1.json
  def show
  end

  # GET /pedidos/new
  def new
    @carnes_disponiveis = Carne.where(:disponibilidade => true)
    @pedido = Pedido.new
    @pedido.item_de_pedidos.build
  end

  # GET /pedidos/1/edit
  def edit
    @carnes_disponiveis = Carne.where(:disponibilidade => true)
  end

  # POST /pedidos
  # POST /pedidos.json
  def create
    debugger
    descricao = ""
    @pedido = Pedido.new(pedido_params)
    @pedido.cliente = Cliente.find(current_usuario.cliente.id)
    
    @pedido.carne = Carne.where(:nome => params[:carne]).first
      if !params[:arroz].nil?
        descricao = "Arroz "+ params[:arroz] + ","
      end
      if params[:feijao] = "Sim"
        descricao = descricao + " Feijao, "
      end

      if params[:farofa] == "Sim"
        descricao = descricao + " Farofa,"
      end

    descricao = descricao + params[:carne] + ", " + params[:acompanhamento] + " Salada: "+ params[:salada]
    #@pedido.valor =
    @pedido.descricao = descricao
    itens = params[:pedido][:item_de_pedidos_attributes]
    if !itens.nil?
      for i in 0..params[:pedido][:item_de_pedidos_attributes].count do
        if itens["#{i}"] != nil
          if itens["#{i}"][:_destroy] == "false"
            itens.delete("#{i}")
          end
        end
      end
    end
    if !itens.blank?
      @pedido.calcular_valor
      else
        @pedido.valor = 0
      end
    #parametros[:valor] = @pedido.valor


    respond_to do |format|
      if @pedido.save
        carne = @pedido.carne
        carne.decrescer
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
    if !itens.nil?
      for i in 0..params[:pedido][:item_de_pedidos_attributes].count do
        if itens["#{i}"] != nil
          if itens["#{i}"][:_destroy] == "1"
            codigo_item = itens["#{i}"][:id]
            item = ItemDePedido.find(codigo_item.to_i)
            item.destroy
            itens.delete("#{i}")
          else
            itens.delete("#{i}")
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

    descricao = descricao + params[:carne] + ", " + params[:acompanhamento] + " Salada: "+ params[:salada]
    @pedido.descricao = descricao
    #@pedido.calcular_valor
    parametros[:valor] = @pedido.valor
    respond_to do |format|
      if @pedido.update(parametros)
        carne = @pedido.carne
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
      params.require(:pedido).permit(:descricao, :valor, :cliente_id, :forma_de_pagamento, item_de_pedidos_attributes: [ :produto_id, :pedido_id, :_destroy])
    end
end
