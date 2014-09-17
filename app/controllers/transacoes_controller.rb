class TransacoesController < ApplicationController
  before_action :set_transacao, only: [:show, :edit, :update, :destroy]

  # GET /transacoes
  # GET /transacoes.json
  def index
    @transacoes = Transacao.all
  end

  # GET /transacoes/1
  # GET /transacoes/1.json
  def show
  end

  # GET /transacoes/new
  def new
    @transacao = Transacao.new
  end

  # GET /transacoes/1/edit
  def edit
  end

  # POST /transacoes
  # POST /transacoes.json
  def create

    quantidade = params[:transacao][:quantidade]
    params[:transacao][:quantidade] = quantidade.split( ',').join('.')  

    @transacao = Transacao.new(transacao_params)

    respond_to do |format|
      if @transacao.save
        format.html { redirect_to @transacao.produto, notice: 'Transacao was successfully created.' }
        format.json { render action: 'show', status: :created, location: @transacao }
      else
        format.html { render action: 'new' }
        format.json { render json: @transacao.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transacoes/1
  # PATCH/PUT /transacoes/1.json
  def update
    quantidade = params[:transacao][:quantidade]
    params[:transacao][:quantidade] = quantidade.split( ',').join('.')  
    
    respond_to do |format|
      if @transacao.update(transacao_params)
        format.html { redirect_to @transacao.produto, notice: 'Transacao was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @transacao.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transacoes/1
  # DELETE /transacoes/1.json
  def destroy
    @transacao.destroy
    respond_to do |format|
      format.html { redirect_to transacoes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transacao
      @transacao = Transacao.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transacao_params
      params.require(:transacao).permit(:produto_id, :valor, :quantidade, :tipo)
    end
end
