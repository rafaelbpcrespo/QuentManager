class SaladasController < ApplicationController
  before_action :set_salada, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  before_action :authenticate_usuario!
  
  # GET /saladas
  # GET /saladas.json
  def index
    @saladas = Salada.all.order(:nome => :asc).paginate(:page => params[:page], :per_page => 10)
  end

  # GET /saladas/1
  # GET /saladas/1.json
  def show
  end

  # GET /saladas/new
  def new
    @salada = Salada.new
  end

  # GET /saladas/1/edit
  def edit
  end

  # POST /saladas
  # POST /saladas.json
  def create
    valor = params[:salada][:valor]
    params[:salada][:valor] = valor.split( ',').join('.')

    @salada = Salada.new(salada_params)

    respond_to do |format|
      if @salada.save
        format.html { redirect_to @salada, notice: 'Salada was successfully created.' }
        format.json { render action: 'show', status: :created, location: @salada }
      else
        format.html { render action: 'new' }
        format.json { render json: @salada.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /saladas/1
  # PATCH/PUT /saladas/1.json
  def update
    valor = params[:salada][:valor]
    params[:salada][:valor] = valor.split( ',').join('.')

    respond_to do |format|
      if @salada.update(salada_params)
        format.html { redirect_to @salada, notice: 'Salada was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @salada.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /saladas/1
  # DELETE /saladas/1.json
  def destroy
    @salada.destroy
    respond_to do |format|
      format.html { redirect_to saladas_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_salada
      @salada = Salada.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def salada_params
      params.require(:salada).permit(:nome, :quantidade, :disponibilidade, :valor, :descricao)
    end
end
