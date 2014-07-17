class CardapiosController < ApplicationController
  before_action :set_cardapio, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  before_action :authenticate_usuario!
  # GET /cardapios
  # GET /cardapios.json
  def index
    @cardapios = Cardapio.all
  end

  # GET /cardapios/1
  # GET /cardapios/1.json
  def show
  end

  # GET /cardapios/new
  def new
    @cardapio = Cardapio.new
  end

  # GET /cardapios/1/edit
  def edit
  end

  # POST /cardapios
  # POST /cardapios.json
  def create
    @cardapio = Cardapio.new(cardapio_params)

    respond_to do |format|
      if @cardapio.save
        format.html { redirect_to @cardapio, notice: 'Nova Cardapio cadastrada com sucesso.' }
        format.json { render action: 'show', status: :created, location: @cardapio }
      else
        format.html { render action: 'new' }
        format.json { render json: @cardapio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cardapios/1
  # PATCH/PUT /cardapios/1.json
  def update
    respond_to do |format|
      if @cardapio.update(cardapio_params)
        format.html { redirect_to @cardapio, notice: 'Cardapio atualizado com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @cardapio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cardapios/1
  # DELETE /cardapios/1.json
  def destroy
    @cardapio.destroy
    respond_to do |format|
      format.html { redirect_to cardapios_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cardapio
      @cardapio = Cardapio.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cardapio_params
      params.require(:cardapio).permit(:nome, :quantidade, :disponibilidade, :tipo, :observacao, :valor)
    end
end
