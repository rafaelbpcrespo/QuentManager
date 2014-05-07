class CarnesController < ApplicationController
  before_action :set_carne, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_usuario!
  # GET /carnes
  # GET /carnes.json
  def index
    @carnes = Carne.all
  end

  # GET /carnes/1
  # GET /carnes/1.json
  def show
  end

  # GET /carnes/new
  def new
    @carne = Carne.new
  end

  # GET /carnes/1/edit
  def edit
  end

  # POST /carnes
  # POST /carnes.json
  def create
    @carne = Carne.new(carne_params)

    respond_to do |format|
      if @carne.save
        format.html { redirect_to @carne, notice: 'Nova Carne cadastrada com sucesso.' }
        format.json { render action: 'show', status: :created, location: @carne }
      else
        format.html { render action: 'new' }
        format.json { render json: @carne.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carnes/1
  # PATCH/PUT /carnes/1.json
  def update
    respond_to do |format|
      if @carne.update(carne_params)
        format.html { redirect_to @carne, notice: 'Carne atualizado com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @carne.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carnes/1
  # DELETE /carnes/1.json
  def destroy
    @carne.destroy
    respond_to do |format|
      format.html { redirect_to carnes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_carne
      @carne = Carne.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def carne_params
      params.require(:carne).permit(:nome, :quantidade, :disponibilidade)
    end
end
