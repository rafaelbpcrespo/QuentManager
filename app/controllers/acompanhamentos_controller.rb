class AcompanhamentosController < ApplicationController
  before_action :set_entrada, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  before_action :authenticate_usuario!
  # GET /acompanhamentos
  # GET /acompanhamentos.json
  def index
    @acompanhamentos = Acompanhamento.all.order(:nome => :asc).paginate(:page => params[:page], :per_page => 10)
  end

  # GET /acompanhamentos/1
  # GET /acompanhamentos/1.json
  def show
  end

  # GET /acompanhamentos/new
  def new
    @acompanhamento = Acompanhamento.new
  end

  # GET /acompanhamentos/1/edit
  def edit
  end

  # POST /acompanhamentos
  # POST /acompanhamentos.json
  def create
    @acompanhamento = Acompanhamento.new(entrada_params)

    respond_to do |format|
      if @acompanhamento.save
        format.html { redirect_to @acompanhamento, notice: 'Acompanhamento was successfully created.' }
        format.json { render action: 'show', status: :created, location: @acompanhamento }
      else
        format.html { render action: 'new' }
        format.json { render json: @acompanhamento.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /acompanhamentos/1
  # PATCH/PUT /acompanhamentos/1.json
  def update
    respond_to do |format|
      if @acompanhamento.update(entrada_params)
        format.html { redirect_to @acompanhamento, notice: 'Acompanhamento was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @acompanhamento.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /acompanhamentos/1
  # DELETE /acompanhamentos/1.json
  def destroy
    @acompanhamento.destroy
    respond_to do |format|
      format.html { redirect_to entradas_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entrada
      @acompanhamento = Acompanhamento.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entrada_params
      params.require(:acompanhamento).permit(:nome, :descricao, :disponibilidade)
    end
end
