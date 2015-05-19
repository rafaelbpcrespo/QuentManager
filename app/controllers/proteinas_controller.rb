class ProteinasController < ApplicationController
  before_action :set_proteina, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  before_action :authenticate_usuario!
  # GET /proteinas
  # GET /proteinas.json
  def index
    @proteinas = Proteina.all.order(:nome => :asc).paginate(:page => params[:page], :per_page => 10).search(params[:search])
  end

  # GET /proteinas/1
  # GET /proteinas/1.json
  def show
  end

  # GET /proteinas/new
  def new
    @proteina = Proteina.new
  end

  # GET /proteinas/1/edit
  def edit
    @proteina.valor = @proteina.valor.to_s.split('.').join(',')
  end

  def desativar
    @proteina = Proteina.find(params[:id])
    @proteina.desativar!
    flash[:notice] = "Proteína desativada com sucesso."
    redirect_to proteinas_path
  end

  # POST /proteinas
  # POST /proteinas.json
  def create
    valor = params[:proteina][:valor]
    params[:proteina][:valor] = valor.split( ',').join('.')
    
    @proteina = Proteina.new(proteina_params)

    respond_to do |format|
      if @proteina.save
        format.html { redirect_to @proteina, notice: 'Proteína cadastrada com sucesso.' }
        format.json { render action: 'show', status: :created, location: @proteina }
      else
        format.html { render action: 'new' }
        format.json { render json: @proteina.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /proteinas/1
  # PATCH/PUT /proteinas/1.json
  def update
    valor = params[:proteina][:valor]
    params[:proteina][:valor] = valor.split( ',').join('.')

    respond_to do |format|
      if @proteina.update(proteina_params)
        format.html { redirect_to @proteina, notice: 'Proteína atualizada com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @proteina.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /proteinas/1
  # DELETE /proteinas/1.json
  def destroy
    @proteina.destroy
    respond_to do |format|
      format.html { redirect_to proteinas_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_proteina
      @proteina = Proteina.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def proteina_params
      params.require(:proteina).permit(:nome, :quantidade, :disponibilidade, :descricao, :valor)
    end
end
