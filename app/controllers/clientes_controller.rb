class ClientesController < ApplicationController
  before_action :set_cliente, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  before_action :authenticate_usuario!

  # GET /clientes
  # GET /clientes.json
  def index
    if current_usuario.admin?
      @clientes = Cliente.paginate(:page => params[:page], :per_page => 10).search(params[:search],params[:empresa])
    else
      @clientes = Cliente.find_all_by_id(current_usuario.cliente.id)
    end
  end

  # GET /clientes/1
  # GET /clientes/1.json
  def show
  end

  # GET /clientes/new
  def new
    @cliente = Cliente.new
  end

  # GET /clientes/1/edit
  def edit
    #Tratando retorno de data do Banco de Dados
    @cliente.data_de_nascimento = @cliente.data_de_nascimento.to_s.split(/\-/).reverse.join('/')
  end

  def bloquear
    @cliente = Cliente.find(params[:id])
  end

  def confirmar_bloqueio
    @cliente = Cliente.find(params[:id])
    @cliente.bloquear!

    if @cliente.save
      BloqueioMailer.bloquear(@cliente.usuario).deliver
      flash[:notice] = "Cliente bloqueado"
    else
      flash[:alert] = "Erro ao bloquear cliente"
    end
    redirect_to clientes_path
  end

  def desbloquear
    @cliente = Cliente.find(params[:id])
  end

  def confirmar_desbloqueio
    @cliente = Cliente.find(params[:id])
    @cliente.desbloquear!

    if @cliente.save
      flash[:notice] = "Cliente bloqueado"
    else
      flash[:alert] = "Erro ao bloquear cliente"
    end
    redirect_to clientes_path
  end


  # POST /clientes
  # POST /clientes.json
  def create
    @cliente = Cliente.new(cliente_params)
    respond_to do |format|
      if @cliente.save
        format.html { redirect_to @cliente, notice: 'Novo Cliente cadastrado com sucesso.' }
        format.json { render action: 'show', status: :created, location: @cliente }
      else
        format.html { render action: 'new' }
        format.json { render json: @cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clientes/1
  # PATCH/PUT /clientes/1.json
  def update
    respond_to do |format|
      if @cliente.update(cliente_params)
        format.html { redirect_to @cliente, notice: 'Cliente atualizado com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clientes/1
  # DELETE /clientes/1.json
  def destroy
    @cliente.destroy
    respond_to do |format|
      format.html { redirect_to clientes_url }
      format.json { head :no_content }
    end
  end

  def search
    @clientes = Cliente.search params[:search]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cliente
      @cliente = Cliente.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cliente_params
      params.require(:cliente).permit(:nome, :celular, :telefone, :ramal, :endereco, :complemento, :empresa_id, :sexo, :data_de_nascimento, :data_de_pagamento, :setor, :cargo, :cpf)
    end
end
