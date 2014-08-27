class PedidosController < ApplicationController
  before_action :set_pedido, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  before_action :authenticate_usuario!

  # GET /pedidos
  # GET /pedidos.json
  def index
    if current_usuario.admin?
      @pedidos = Pedido.where(created_at: (Time.now.midnight)..Time.now.midnight + 1.day).paginate(:page => params[:page], :per_page => 10)
    else
      @pedidos = Pedido.where(created_at: (Time.now.midnight)..Time.now.midnight + 1.day, :cliente_id => current_usuario.cliente.id).paginate(:page => params[:page], :per_page => 10)
    end
  end

  # GET /pedidos/1
  # GET /pedidos/1.json
  def show
  end

  def confirmar
    if @pedido.situacao == "Cancelado"
      flash[:alert] = "Você não pode confirmar um pedido já cancelado."
    else
      if @pedido.confirmar! == 0
        flash[:alert] = "Você não pode confirmar este pedido pois existem itens indisponíveis no estoque."
      else
        flash[:notice] = "Pedido confimado com sucesso."
      end
    end
    redirect_to pedidos_path
  end

  def cancelar
    @pedido = Pedido.find(params[:id])
    @pedido.cancelar!
    flash[:notice] = "Pedido cancelado com sucesso."
    redirect_to pedidos_path
  end


  # GET /pedidos/new
  def new
    @proteinas_disponiveis = Proteina.where(:disponibilidade => true)
    @bebidas_disponiveis = Bebida.where(:disponibilidade => true)
    @acompanhamentos_disponiveis = Acompanhamento.where(:disponibilidade => true)
    @guarnicoes_disponiveis = Guarnicao.where(:disponibilidade => true)
    @saladas_disponiveis = Salada.where(:disponibilidade => true)
    @pedido = Pedido.new
    # if !params[:cliente_id].nil?
    #   @pedido.cliente = Cliente.find(params[:cliente_id].to_i)
    # end
    #@pedido.item_de_pedidos.build
    @pedido.pedidos_proteinas.build
    @pedido.pedidos_guarnicoes.build
    @pedido.pedidos_saladas.build
    @pedido.pedidos_bebidas.build
    @pedido.pedidos_acompanhamentos.build
  end

  # GET /pedidos/1/edit
  def edit
    debugger
    @proteinas_disponiveis = Proteina.where(:disponibilidade => true)
    @pedido.proteinas.map { |proteina| @proteinas_disponiveis << proteina unless @proteinas_disponiveis.include? proteina }
    @proteinas_disponiveis.sort!
    @guarnicoes_disponiveis = Guarnicao.where(:disponibilidade => true)
    @pedido.guarnicoes.map { |guarnicao| @guarnicoes_disponiveis << guarnicao unless @guarnicoes_disponiveis.include? guarnicao }
    @guarnicoes_disponiveis.sort!
    @saladas_disponiveis = Salada.where(:disponibilidade => true)
    @pedido.saladas.map { |salada| @saladas_disponiveis << salada unless @saladas_disponiveis.include? salada }
    @saladas_disponiveis.sort!
    @acompanhamentos_disponiveis = Acompanhamento.where(:disponibilidade => true)
    @bebidas_disponiveis = Bebida.where(:disponibilidade => true)
    @pedido.bebidas.map { |bebida| @bebidas_disponiveis << bebida unless @bebidas_disponiveis.include? bebida }
    @bebidas_disponiveis.sort!

  end

  # POST /pedidos
  # POST /pedidos.json
  def create
    debugger
    # valor = params[:pedido][:valor]
    # params[:pedido][:valor] = valor.split( ',').join('.')
    conta = Conta.find_by_cliente_id(params[:pedido][:cliente_id])
    @proteinas_disponiveis = Proteina.where(:disponibilidade => true)
    @acompanhamentos_disponiveis = Acompanhamento.where(:disponibilidade => true)
    @guarnicoes_disponiveis = Guarnicao.where(:disponibilidade => true)
    @saladas_disponiveis = Salada.where(:disponibilidade => true)
    @bebidas_disponiveis = Bebida.where(:disponibilidade => true)
    #descricao = ""
    @pedido = Pedido.new(pedido_params)
    @pedido.conta_id = conta.id.to_i
    # if @pedido.cliente.nil?
    #   @pedido.cliente = Cliente.find(current_usuario.cliente.id)
    #   @pedido.conta = Conta.find_by_cliente_id(current_usuario.id)
    # end
    # ENTRADAS #
    # acompanhamentos = params[:pedido][:acompanhamento_ids]
    # acompanhamentos.each do |id|
    #   if !id.blank?
    #     acompanhamento = Acompanhamento.find(id.to_i)
    #     @pedido.pedidos_acompanhamentos.new(:acompanhamento_id => id)
    #     #@pedido.acompanhamentos << acompanhamento
    #   end
    # end
    ###### FINAL ENTRADAS ########
    acompanhamentos = Acompanhamento.where(:disponibilidade => true).count
    for i in 0...acompanhamentos do
      if !params["acompanhamento_#{i}"].blank?
        @pedido.pedidos_acompanhamentos.new(:acompanhamento_id => params["acompanhamento_#{i}"], :quantidade => params["quantidade_acompanhamento_#{i}"])
      end
    end

    proteinas = Proteina.where(:disponibilidade => true).count
    for i in 0...proteinas do
      if !params["proteina_#{i}"].blank?
        @pedido.pedidos_proteinas.new(:proteina_id => params["proteina_#{i}"], :quantidade => params["quantidade_proteina_#{i}"])
      end
    end

    guarnicoes = Guarnicao.where(:disponibilidade => true).count
    for i in 0...guarnicoes do
      if !params["guarnicao_#{i}"].blank?
        @pedido.pedidos_guarnicoes.new(:guarnicao_id => params["guarnicao_#{i}"], :quantidade => params["quantidade_guarnicao_#{i}"])
      end
    end

    saladas = Salada.where(:disponibilidade => true).count
    for i in 0...saladas do
      if !params["salada_#{i}"].blank?
        @pedido.pedidos_saladas.new(:salada_id => params["salada_#{i}"], :quantidade => params["quantidade_salada_#{i}"])
      end
    end

    bebidas = Bebida.where(:disponibilidade => true).count
    for i in 0...bebidas do
      if !params["bebida_#{i}"].blank?
        @pedido.pedidos_bebidas.new(:bebida_id => params["bebida_#{i}"], :quantidade => params["quantidade_bebida_#{i}"])
      end
    end
    

    #@pedido.proteinas << Proteina.where(:nome => params[:proteina]).first

    # debugger
    #  if !params[:arroz].nil?
    #     descricao = "Arroz "+ params[:arroz] + ","
    #   end
    #   if params[:feijao] = "Sim"
    #     descricao = descricao + " Feijao, "
    #   end

    #   if params[:farofa] == "Sim"
    #     descricao = descricao + " Farofa,"
    #   end

    # descricao = descricao + params[:proteina] + ", " + params[:acompanhamento] + " Salada: "+ params[:salada]
    # @pedido.descricao = descricao
    # itens = params[:pedido][:item_de_pedidos_attributes]

    # if !itens.nil?
    #   for i in 0..params[:pedido][:item_de_pedidos_attributes].count do
    #     if itens["#{i}"] != nil
    #       if itens["#{i}"][:produto_id].blank?
    #         itens.delete("#{i}")
    #       end
    #     else
    #       itens.delete("#{i}")
    #     end
    #   end
    # end
    #   if !itens.blank?
    #     @pedido.calcular_valor
    #   else
    #     @pedido.item_de_pedidos.destroy_all
    #     @pedido.valor = 0
    #   end
    #   if !itens.nil?
    #     params[:pedido][:item_de_pedidos_attributes].replace(itens)
    #   end

      @pedido.situacao = "Em processamento"
    #parametros[:valor] = @pedido.valor

    respond_to do |format|
      if @pedido.save
        @pedido.calcular_valor
        @pedido.conta.calcular_saldo
        #@pedido.adicionar_conta
        #proteina = @pedido.proteina
        #proteina.decrescer
        format.html { redirect_to @pedido, notice: 'Novo Pedido realizado com sucesso.' }
        format.json { render action: 'show', status: :created, location: @pedido }
      else
        format.html { render action: 'new' }
        format.json { render json: @pedido.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pedidos/1
  # PATCH/PUT /pedidos/1.json
  def update
    debugger
    # valor = params[:pedido][:valor]
    # params[:pedido][:valor] = valor.split( ',').join('.')

#    descricao = ""
    @pedido.cliente = Cliente.find_by_id(params[:cliente_id].to_i)

    pa = @pedido.pedidos_acompanhamentos
    acompanhamento_editado = []
    acompanhamento_novo = []
    acompanhamentos = Acompanhamento.where(:disponibilidade => true).count
    for i in 0...acompanhamentos do
      acompanhamento=nil
      if  !params["acompanhamento_#{i}"].blank?
        acompanhamento = Acompanhamento.find(params["acompanhamento_#{i}"])
      end
      if @pedido.acompanhamentos.include? acompanhamento
        atualiza_acompanhamento = @pedido.pedidos_acompanhamentos.find_by_acompanhamento_id(params["acompanhamento_#{i}"])
        atualiza_acompanhamento.quantidade = params["quantidade_acompanhamento_#{i}"].to_i
        acompanhamento_editado << atualiza_acompanhamento
        atualiza_acompanhamento.save
      elsif (@pedido.acompanhamentos.include? acompanhamento && params["quantidade_acompanhamento_#{i}"] == 0)
        atualiza_acompanhamento = @pedido.pedidos_acompanhamentos.find_by_acompanhamento_id(params["acompanhamento_#{i}"])
        atualiza_acompanhamento.destroy
      elsif (!params["acompanhamento_#{i}"].blank? && !params["quantidade_acompanhamento_#{i}"].nil?)
#        @pedido.pedidos_acompanhamentos.
        acompanhamento_novo << @pedido.pedidos_acompanhamentos.create!(:acompanhamento_id => params["acompanhamento_#{i}"], :quantidade => params["quantidade_acompanhamento_#{i}"])
      end
    end
      acompanhamentos_removidos = pa - acompanhamento_editado
      acompanhamentos_removidos = acompanhamentos_removidos - acompanhamento_novo
      acompanhamentos_removidos.each do |acompanhamento_removido|
        acompanhamento_removido.destroy
      end

    proteina_novo = []
    pc = @pedido.pedidos_proteinas
    proteina_editado = []
    proteinas = Proteina.where(:disponibilidade => true).count
    for i in 0..proteinas do
      proteina=nil
      if  !params["proteina_#{i}"].blank?
        proteina = Proteina.find(params["proteina_#{i}"])
      end
      if (@pedido.proteinas.include? proteina && params["quantidade_proteina_#{i}"] != 0)
        atualiza_proteina = @pedido.pedidos_proteinas.find_by_proteina_id(params["proteina_#{i}"])
        atualiza_proteina.quantidade = params["quantidade_proteina_#{i}"].to_i
        proteina_editado << atualiza_proteina
        atualiza_proteina.save
      elsif (@pedido.proteinas.include? proteina && params["quantidade_proteina_#{i}"] == 0)
        atualiza_proteina = @pedido.pedidos_proteinas.find_by_proteina_id(params["proteina_#{i}"])
        atualiza_proteina.destroy
      elsif (!params["proteina_#{i}"].blank? && !params["quantidade_proteina_#{i}"].nil?)
#        @pedido.pedidos_proteinas.
        proteina_novo << @pedido.pedidos_proteinas.create!(:proteina_id => params["proteina_#{i}"], :quantidade => params["quantidade_proteina_#{i}"])
        proteina_novo.last.proteina.decrescer(proteina_novo.last.quantidade)
      end
    end
    #### Removendo proteinas após edição ####
    proteinas_removidos = pc - proteina_editado
    proteinas_removidos = proteinas_removidos - proteina_novo
    proteinas_removidos.each do |proteina_removido|
      proteina_removido.proteina.acrescer(proteina_removido.quantidade)
      #proteina_removido.proteina.quantidade = proteina_removido.proteina.quantidade + proteina_removido.quantidade
      #proteina = proteina_removido.proteina
      #proteina.save
      proteina_removido.destroy
    end
    ##################### Fim proteinas removidos #####################


    guarnicao_novo = []
    pc = @pedido.pedidos_guarnicoes
    guarnicao_editado = []
    guarnicoes = Guarnicao.where(:disponibilidade => true).count
    for i in 0..guarnicoes do
      guarnicao=nil
      if  !params["guarnicao_#{i}"].blank?
        guarnicao = Guarnicao.find(params["guarnicao_#{i}"])
      end
      if @pedido.guarnicoes.include? guarnicao
        atualiza_guarnicao = @pedido.pedidos_guarnicoes.find_by_guarnicao_id(params["guarnicao_#{i}"])
        atualiza_guarnicao.quantidade = params["quantidade_guarnicao_#{i}"].to_i
        guarnicao_editado << atualiza_guarnicao
        atualiza_guarnicao.save
      elsif (@pedido.guarnicoes.include? guarnicao && params["quantidade_guarnicao_#{i}"] == 0)
        atualiza_guarnicao = @pedido.pedidos_guarnicoes.find_by_guarnicao_id(params["guarnicao_#{i}"])
        atualiza_guarnicao.destroy
      elsif (!params["guarnicao_#{i}"].blank? && !params["quantidade_guarnicao_#{i}"].nil?)
#        @pedido.pedidos_proteinas.
        guarnicao_novo << @pedido.pedidos_guarnicoes.create!(:guarnicao_id => params["guarnicao_#{i}"], :quantidade => params["quantidade_guarnicao_#{i}"])
        guarnicao_novo.last.guarnicao.decrescer(guarnicao_novo.last.quantidade)
      end
    end
    #### Removendo proteinas após edição ####
    guarnicoes_removidos = pc - guarnicao_editado
    guarnicoes_removidos = guarnicoes_removidos - guarnicao_novo
    guarnicoes_removidos.each do |guarnicao_removido|
      guarnicao_removido.guarnicao.acrescer(guarnicao_removido.quantidade)
      #proteina_removido.proteina.quantidade = proteina_removido.proteina.quantidade + proteina_removido.quantidade
      #proteina = proteina_removido.proteina
      #proteina.save
      guarnicao_removido.destroy
    end
    ##################### Fim guarnicoes removidos #####################


    salada_novo = []
    pc = @pedido.pedidos_saladas
    salada_editado = []
    saladas = Salada.where(:disponibilidade => true).count
    for i in 0..saladas do
      salada=nil
      if  !params["salada_#{i}"].blank?
        salada = Salada.find(params["salada_#{i}"])
      end
      if @pedido.saladas.include? salada
        atualiza_salada = @pedido.pedidos_saladas.find_by_salada_id(params["salada_#{i}"])
        atualiza_salada.quantidade = params["quantidade_salada_#{i}"].to_i
        salada_editado << atualiza_salada
        atualiza_salada.save
      elsif (@pedido.saladas.include? salada && params["quantidade_salada_#{i}"] == 0)
        atualiza_salada = @pedido.pedidos_saladas.find_by_salada_id(params["salada_#{i}"])
        atualiza_salada.destroy
      elsif (!params["salada_#{i}"].blank? && !params["quantidade_salada_#{i}"].nil?)
#        @pedido.pedidos_proteinas.
        salada_novo << @pedido.pedidos_saladas.create!(:salada_id => params["salada_#{i}"], :quantidade => params["quantidade_salada_#{i}"])
        salada_novo.last.salada.decrescer(salada_novo.last.quantidade)
      end
    end
    #### Removendo proteinas após edição ####
    saladas_removidos = pc - salada_editado
    saladas_removidos = saladas_removidos - salada_novo
    saladas_removidos.each do |salada_removido|
      salada_removido.salada.acrescer(salada_removido.quantidade)
      #proteina_removido.proteina.quantidade = proteina_removido.proteina.quantidade + proteina_removido.quantidade
      #proteina = proteina_removido.proteina
      #proteina.save
      salada_removido.destroy
    end
    ##################### Fim saladas removidos #####################


    bebida_novo = []
    pc = @pedido.pedidos_bebidas
    bebida_editado = []
    bebidas = Bebida.where(:disponibilidade => true).count
    for i in 0..bebidas do
      bebida=nil
      if  !params["bebida_#{i}"].blank?
        bebida = Bebida.find(params["bebida_#{i}"])
      end
      if @pedido.bebidas.include? bebida
        atualiza_bebida = @pedido.pedidos_bebidas.find_by_bebida_id(params["bebida_#{i}"])
        atualiza_bebida.quantidade = params["quantidade_bebida_#{i}"].to_i
        bebida_editado << atualiza_bebida
        atualiza_bebida.save
      elsif (@pedido.bebidas.include? bebida && params["quantidade_bebida_#{i}"] == 0)
        atualiza_bebida = @pedido.pedidos_bebidas.find_by_bebida_id(params["bebida_#{i}"])
        atualiza_bebida.destroy
      elsif (!params["bebida_#{i}"].blank? && !params["quantidade_bebida_#{i}"].nil?)
#        @pedido.pedidos_proteinas.
        bebida_novo << @pedido.pedidos_bebidas.create!(:bebida_id => params["bebida_#{i}"], :quantidade => params["quantidade_bebida_#{i}"])
        bebida_novo.last.bebida.decrescer(bebida_novo.last.quantidade)
      end
    end
    #### Removendo proteinas após edição ####
    bebidas_removidos = pc - bebida_editado
    bebidas_removidos = bebidas_removidos - bebida_novo
    bebidas_removidos.each do |bebida_removido|
      bebida_removido.bebida.acrescer(bebida_removido.quantidade)
      #proteina_removido.proteina.quantidade = proteina_removido.proteina.quantidade + proteina_removido.quantidade
      #proteina = proteina_removido.proteina
      #proteina.save
      bebida_removido.destroy
    end
    ##################### Fim bebidas removidos #####################

    # proteinas = Proteina.where(:disponibilidade => true, :tipo => "Carne").count
    # for i in 0...proteinas do
    #   if !params["proteina_#{i}"].blank?
    #     @pedido.pedidos_proteinas.new(:proteina_id => params["proteina_#{i}"], :quantidade => params["quantidade_#{i}"])
    #   end
    # end
debugger
#    parametros = pedido_params


    # itens = params[:pedido][:item_de_pedidos_attributes]
    # vetor_itens = params[:pedido][:item_de_pedidos_attributes].to_a
    # if !itens.nil?
    #   for indice in 0..vetor_itens.count do
    #     if vetor_itens[indice] != nil
    #       puts "DELETAR"
    #       if vetor_itens[indice][1][:_destroy] == "1"
    #         codigo_item = vetor_itens[indice][1]
    #         item = ItemDePedido.find(codigo_item.to_i)
    #         item.destroy
    #         itens.delete("#{vetor_itens[indice][0]}")
    #       elsif vetor_itens[indice][1][:produto_id].blank?
    #         puts "IGNORAR"
    #         itens.delete("#{vetor_itens[indice][0]}")
    #         #itens.delete("#{i}")
    #       end
    #     end
    #   end
    #     parametros[:item_de_pedidos_attributes].replace(itens)
    # end

    #   if !itens.blank?
    #     @pedido.calcular_valor
    #   end
#        @pedido.valor = 0 + params[:valor].to_f
 #     end
    #   if !params[:arroz].nil?
    #     descricao = "Arroz "+ params[:arroz]  + ","
    #   end
    #   if params[:feijao] = "Sim"
    #     descricao = descricao + " Feijao, "
    #   end

    #   if params[:farofa] == "Sim"
    #     descricao = descricao + " Farofa,"
    #   end

    # descricao = descricao + params[:proteina] + ", " + params[:acompanhamento] + " Salada: "+ params[:salada]
    # @pedido.descricao = descricao
    #@pedido.calcular_valor
    
    #parametros[:valor] = @pedido.valor
    respond_to do |format|
      if @pedido.update(pedido_params)
        @pedido.calcular_valor
        @pedido.conta.calcular_saldo
        #proteina = @pedido.proteina
        #carne.decrescer        
        format.html { redirect_to @pedido, notice: 'Pedido atualizado com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @pedido.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pedidos/1
  # DELETE /pedidos/1.json
  def destroy
    @pedido.destroy
    respond_to do |format|
      format.html { redirect_to pedidos_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pedido
      @pedido = Pedido.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pedido_params
      #debugger
      params.require(:pedido).permit(:proteinas, :bebidas, :acompanhamentos, :guarnicoes, :saladas,:valor, :id, :cliente_id, :situacao, :conta)
    end
end
