class SobremesasController < ApplicationController
  before_action :set_sobremesa, only: [:show, :edit, :update, :destroy]

  # GET /sobremesas
  # GET /sobremesas.json
  def index
    @sobremesas = Sobremesa.all.order(:nome => :asc).paginate(:page => params[:page], :per_page => 10)
  end

  # GET /sobremesas/1
  # GET /sobremesas/1.json
  def show
  end

  # GET /sobremesas/new
  def new
    @sobremesa = Sobremesa.new
  end

  # GET /sobremesas/1/edit
  def edit
  end

  def desativar
    @sobremesa = Sobremesa.find(params[:id])
    @sobremesa.desativar!
    flash[:notice] = "Sobremesa desativada com sucesso."
    redirect_to sobremesas_path
  end

  # POST /sobremesas
  # POST /sobremesas.json
  def create
    valor = params[:sobremesa][:valor]
    params[:sobremesa][:valor] = valor.split( ',').join('.')

    @sobremesa = Sobremesa.new(sobremesa_params)

    respond_to do |format|
      if @sobremesa.save
        format.html { redirect_to @sobremesa, notice: 'Sobremesa cadastrada com sucesso.' }
        format.json { render action: 'show', status: :created, location: @sobremesa }
      else
        format.html { render action: 'new' }
        format.json { render json: @sobremesa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sobremesas/1
  # PATCH/PUT /sobremesas/1.json
  def update
    valor = params[:sobremesa][:valor]
    params[:sobremesa][:valor] = valor.split( ',').join('.')
    
    respond_to do |format|
      if @sobremesa.update(sobremesa_params)
        format.html { redirect_to @sobremesa, notice: 'Sobremesa atualizada com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @sobremesa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sobremesas/1
  # DELETE /sobremesas/1.json
  def destroy
    @sobremesa.destroy
    respond_to do |format|
      format.html { redirect_to sobremesas_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sobremesa
      @sobremesa = Sobremesa.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sobremesa_params
      params.require(:sobremesa).permit(:nome, :quantidade, :valor, :disponibilidade, :descricao)
    end
end
