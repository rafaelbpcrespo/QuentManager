class ProdutosController < ApplicationController
  before_action :set_produto, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  before_action :authenticate_usuario!

  # GET /produtos
  # GET /produtos.json
  def index
    @produtos = Produto.paginate(:page => params[:page], :per_page => 10)
    #Produto.paginate(:page => params[:page], :per_page => 30)
    #@produtos = Produto.all
  end

  # GET /produtos/1
  # GET /produtos/1.json
  def show
  end

  # GET /produtos/new
  def new
    @produto = Produto.new
  end

  # GET /produtos/1/edit
  def edit
  end

  # POST /produtos
  # POST /produtos.json
  def create
    quantidade = params[:produto][:quantidade]
    params[:produto][:quantidade] = quantidade.split( ',').join('.')  

    @produto = Produto.new(produto_params)

    respond_to do |format|
      if @produto.save
        format.html { flash[:notice] = 'Produto cadastrado com sucesso.'
                                redirect_to @produto }
        format.json { render action: 'show', status: :created, location: @produto }
      else
        format.html { render action: 'new' }
        format.json { render json: @produto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /produtos/1
  # PATCH/PUT /produtos/1.json
  def update
    quantidade = params[:produto][:quantidade]
    params[:produto][:quantidade] = quantidade.split( ',').join('.')  

    respond_to do |format|
      if @produto.update(produto_params)
        format.html { redirect_to @produto, notice: 'Produto atualizado com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @produto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /produtos/1
  # DELETE /produtos/1.json
  def destroy
    @produto.destroy
    respond_to do |format|
      format.html { redirect_to produtos_url }
      format.json { head :no_content }
    end
  end

  def atualizar

  end

  def atualizar_estoque
    produto = Produto.find(params[:id])
    quantidade = params[:qtd].to_i
    if params[:tipo] == "Adicionar"
      produto.atualizar(quantidade)
    elsif params[:tipo] == "Subtrair"
      quantidade = quantidade * (-1)
      produto.atualizar(quantidade)
    end
    redirect_to produto_path(produto)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_produto
      @produto = Produto.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def produto_params
      params.require(:produto).permit(:nome, :produto_categoria_id, :produto_tipo_id, :quantidade, :limite_minimo, :categoria)
    end
end
