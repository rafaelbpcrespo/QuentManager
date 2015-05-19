class GuarnicoesController < ApplicationController
  before_action :set_guarnicao, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  before_action :authenticate_usuario!
  # GET /guarnicoes
  # GET /guarnicoes.json
  def index
    @guarnicoes = Guarnicao.all.order(:nome => :asc).paginate(:page => params[:page], :per_page => 10).search(params[:search])
  end

  # GET /guarnicoes/1
  # GET /guarnicoes/1.json
  def show
  end

  # GET /guarnicoes/new
  def new
    @guarnicao = Guarnicao.new
  end

  # GET /guarnicoes/1/edit
  def edit
    @guarnicao.valor = @guarnicao.valor.to_s.split('.').join(',')
  end

  def desativar
    @guarnicao = Guarnicao.find(params[:id])
    @guarnicao.desativar!
    flash[:notice] = "Guarnição desativada com sucesso."
    redirect_to guarnicoes_path
  end

  # POST /guarnicoes
  # POST /guarnicoes.json
  def create
    valor = params[:guarnicao][:valor]
    params[:guarnicao][:valor] = valor.split( ',').join('.')  
    
    @guarnicao = Guarnicao.new(guarnicao_params)

    respond_to do |format|
      if @guarnicao.save
        format.html { redirect_to @guarnicao, notice: 'Guarnição cadastrada com sucesso.' }
        format.json { render action: 'show', status: :created, location: @guarnicao }
      else
        format.html { render action: 'new' }
        format.json { render json: @guarnicao.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /guarnicoes/1
  # PATCH/PUT /guarnicoes/1.json
  def update
    valor = params[:guarnicao][:valor]
    params[:guarnicao][:valor] = valor.split( ',').join('.')

    respond_to do |format|
      if @guarnicao.update(guarnicao_params)
        format.html { redirect_to @guarnicao, notice: 'Guarnição atualizada com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @guarnicao.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /guarnicoes/1
  # DELETE /guarnicoes/1.json
  def destroy
    @guarnicao.destroy
    respond_to do |format|
      format.html { redirect_to guarnicoes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_guarnicao
      @guarnicao = Guarnicao.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def guarnicao_params
      params.require(:guarnicao).permit(:nome, :quantidade, :disponibilidade, :valor, :descricao)
    end
end
