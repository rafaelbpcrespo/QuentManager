class EmpresasController < ApplicationController
  before_action :set_empresa, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  before_action :authenticate_usuario!
  # GET /empresas
  # GET /empresas.json
  def index
    @empresas = Empresa.all.order(:nome => :asc).paginate(:page => params[:page], :per_page => 10)
  end

  # GET /empresas/1
  # GET /empresas/1.json
  def show
  end

  # GET /empresas/new
  def new
    @empresa = Empresa.new
  end

  # GET /empresas/1/edit
  def edit
  end

  def bloquear
    @empresa = Empresa.find(params[:id])
  end

  def confirmar_bloqueio
    @empresa = Empresa.find(params[:id])
    @empresa.bloquear!

    if @empresa.save
      flash[:notice] = "Empresa bloqueada"
    else
      flash[:alert] = "Erro ao bloquear empresa."
    end
    redirect_to empresas_path
  end

  def desbloquear
    @empresa = Empresa.find(params[:id])
  end

  def confirmar_desbloqueio
    @empresa = Empresa.find(params[:id])
    @empresa.desbloquear!

    if @empresa.save
      flash[:notice] = "Empresa bloqueada"
    else
      flash[:alert] = "Erro ao bloquear empresa."
    end
    redirect_to empresas_path
  end


  # POST /empresas
  # POST /empresas.json
  def create
    @empresa = Empresa.new(empresa_params)

    respond_to do |format|
      if @empresa.save
        format.html { redirect_to @empresa, notice: 'Empresa cadastrada com sucesso.' }
        format.json { render action: 'show', status: :created, location: @empresa }
      else
        format.html { render action: 'new' }
        format.json { render json: @empresa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /empresas/1
  # PATCH/PUT /empresas/1.json
  def update
    respond_to do |format|
      if @empresa.update(empresa_params)
        format.html { redirect_to @empresa, notice: 'Empresa atualizada com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @empresa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /empresas/1
  # DELETE /empresas/1.json
  def destroy
    @empresa.destroy
    respond_to do |format|
      format.html { redirect_to empresas_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_empresa
      @empresa = Empresa.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def empresa_params
      params.require(:empresa).permit(:nome, :telefone, :endereco, :observacao)
    end
end
