class BebidasController < ApplicationController
  before_action :set_bebida, only: [:show, :edit, :update, :destroy]

  # GET /bebidas
  # GET /bebidas.json
  def index
    @bebidas = Bebida.all.order(:nome => :asc).paginate(:page => params[:page], :per_page => 10)
  end

  # GET /bebidas/1
  # GET /bebidas/1.json
  def show
  end

  # GET /bebidas/new
  def new
    @bebida = Bebida.new
  end

  # GET /bebidas/1/edit
  def edit
    @bebida.valor = @bebida.valor.to_s.split('.').join(',')
  end

  def desativar
    @bebida = Bebida.find(params[:id])
    @bebida.desativar!
    flash[:notice] = "Bebida desativada com sucesso."
    redirect_to bebidas_path
  end


  # POST /bebidas
  # POST /bebidas.json
  def create
    valor = params[:bebida][:valor]
    params[:bebida][:valor] = valor.split( ',').join('.')

    @bebida = Bebida.new(bebida_params)

    respond_to do |format|
      if @bebida.save
        format.html { redirect_to @bebida, notice: 'Bebida cadastrada com sucesso.' }
        format.json { render action: 'show', status: :created, location: @bebida }
      else
        format.html { render action: 'new' }
        format.json { render json: @bebida.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bebidas/1
  # PATCH/PUT /bebidas/1.json
  def update
    valor = params[:bebida][:valor]
    params[:bebida][:valor] = valor.split( ',').join('.')  
    
    respond_to do |format|
      if @bebida.update(bebida_params)
        format.html { redirect_to @bebida, notice: 'Bebida atualizada com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @bebida.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bebidas/1
  # DELETE /bebidas/1.json
  def destroy
    @bebida.destroy
    respond_to do |format|
      format.html { redirect_to bebidas_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bebida
      @bebida = Bebida.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bebida_params
      params.require(:bebida).permit(:nome, :quantidade, :valor, :disponibilidade, :tipo)
    end
end
