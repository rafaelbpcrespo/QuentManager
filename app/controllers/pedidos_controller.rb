class PedidosController < ApplicationController
  before_action :set_pedido, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  before_action :authenticate_usuario!

  # GET /pedidos
  # GET /pedidos.json
  def index
    if current_usuario.admin?
      @pedidos = Pedido.search(params[:situacao],params[:empresa])
      if !params[:empresa].blank?
        @nome_da_empresa = Empresa.find(params[:empresa]).nome
        @quantidade_de_pedidos = @pedidos.count
      else
        @nome_da_empresa = "Todas as Empresas"
        @quantidade_de_pedidos = @pedidos.count
      end
    else
      @pedidos = Pedido.where(:cliente_id => current_usuario.cliente.id)
    end
  end

  # GET /pedidos/1
  # GET /pedidos/1.json
  def show
  end

  def confirmar
    if @pedido.cliente.bloqueado? && current_usuario.usuario?
      flash[:alert] = "Você não pode confirmar um pedido pois seu cadastro está bloqueado. Favor entrar em contato com a Si Quitutes."
    elsif @pedido.situacao == "Cancelado" && current_usuario.usuario?
      flash[:alert] = "Você não pode confirmar um pedido já cancelado."
    elsif @pedido.situacao == "Confirmado"
      flash[:alert] = "Este pedido já foi confirmado."
    elsif (((DateTime.now < @pedido.created_at.change(hour: Pedido::HORARIO_LIMITE_MIN)) || (DateTime.now > @pedido.created_at.change(hour: Pedido::HORARIO_LIMITE_MAX))) && (current_usuario.usuario?))
      flash[:alert] = "Horário limite para confirmação ultrapassado."
    else
      if @pedido.confirmar! == 0
        flash[:alert] = "Você não pode confirmar este pedido pois existem itens indisponíveis no estoque."
      else
        PedidoMailer.confirmar_pedido(@pedido.cliente.usuario,@pedido).deliver
        flash[:notice] = "Pedido confimado com sucesso."
      end
    end
    redirect_to pedidos_path
  end

  def cancelar
    @pedido = Pedido.find(params[:id])
    if (DateTime.now > @pedido.created_at.change(hour: Pedido::HORARIO_LIMITE_MAX)) && !(current_usuario.admin? || current_usuario.gerente?)
      flash[:alert] = "Horário limite para cancelamento ultrapassado."
    elsif @pedido.situacao == "Cancelado"
      flash[:alert] = "Este pedido já foi cancelado."
    else
      @pedido.cancelar!
      flash[:notice] = "Pedido cancelado com sucesso."
  end
    redirect_to pedidos_path
  end


  # GET /pedidos/new
  def new
    @proteinas_disponiveis = Proteina.where(:disponibilidade => true)
    @bebidas_disponiveis = Bebida.where(:disponibilidade => true)
    @sobremesas_disponiveis = Sobremesa.where(:disponibilidade => true)
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
    @pedido.pedidos_sobremesas.build
    @pedido.pedidos_acompanhamentos.build
  end

  # GET /pedidos/1/edit
  def edit
    if @pedido.situacao == "Em processamento"
      @flag_situacao = 1
    end
    
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
    @sobremesas_disponiveis = Sobremesa.where(:disponibilidade => true)
    @pedido.sobremesas.map { |sobremesa| @sobremesas_disponiveis << sobremesa unless @sobremesas_disponiveis.include? sobremesa }
    @sobremesas_disponiveis.sort!

  end

  # POST /pedidos
  # POST /pedidos.json
  def create
    # valor = params[:pedido][:valor]
    # params[:pedido][:valor] = valor.split( ',').join('.')
    conta = Conta.find_by_cliente_id(params[:pedido][:cliente_id])
    @proteinas_disponiveis = Proteina.where(:disponibilidade => true)
    @acompanhamentos_disponiveis = Acompanhamento.where(:disponibilidade => true)
    @guarnicoes_disponiveis = Guarnicao.where(:disponibilidade => true)
    @saladas_disponiveis = Salada.where(:disponibilidade => true)
    @bebidas_disponiveis = Bebida.where(:disponibilidade => true)
    @sobremesas_disponiveis = Sobremesa.where(:disponibilidade => true)
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
    
    sobremesas = Sobremesa.where(:disponibilidade => true).count
    for i in 0...sobremesas do
      if !params["sobremesa_#{i}"].blank?
        @pedido.pedidos_sobremesas.new(:sobremesa_id => params["sobremesa_#{i}"], :quantidade => params["quantidade_sobremesa_#{i}"])
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
        format.html { redirect_to @pedido }
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
    # valor = params[:pedido][:valor]
    # params[:pedido][:valor] = valor.split( ',').join('.')

    #Esta verificacao e feita para evitar que quando um NOVO pedido nao possa ser confirmado por falta de itens disponiveis, os itens do pedido não sejam decrescidos.
    if @pedido.situacao == "Em processamento"
      @flag_situacao = 1
    end
#    descricao = ""
    @pedido.situacao = "Em processamento"
    @pedido.save
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
      if (( @pedido.acompanhamentos.include? acompanhamento) && ( !params["acompanhamento_#{i}"].blank?) && (params["quantidade_acompanhamento_#{i}"].to_i != @pedido.pedidos_acompanhamentos.find_by_acompanhamento_id(acompanhamento.id).quantidade) && (@flag_situacao != 1))
        atualiza_acompanhamento = @pedido.pedidos_acompanhamentos.find_by_acompanhamento_id(params["acompanhamento_#{i}"])
        acompanhamento.acrescer(atualiza_acompanhamento.quantidade) #Aqui adiciona o que tinha ficado no pedido antes de ser editado.
        atualiza_acompanhamento.quantidade = params["quantidade_acompanhamento_#{i}"].to_i
        acompanhamento_editado << atualiza_acompanhamento
        atualiza_acompanhamento.save
      elsif (( @pedido.acompanhamentos.include? acompanhamento) && ( !params["acompanhamento_#{i}"].blank?) && (params["quantidade_acompanhamento_#{i}"].to_i == @pedido.pedidos_acompanhamentos.find_by_acompanhamento_id(acompanhamento.id).quantidade))
        atualiza_acompanhamento = @pedido.pedidos_acompanhamentos.find_by_acompanhamento_id(params["acompanhamento_#{i}"])
        acompanhamento.acrescer(atualiza_acompanhamento.quantidade)
        acompanhamento_editado << atualiza_acompanhamento
      elsif (( !params["acompanhamento_#{i}"].blank?) && ( !params["quantidade_acompanhamento_#{i}"].nil?))
        acompanhamento_novo << @pedido.pedidos_acompanhamentos.create!(:acompanhamento_id => params["acompanhamento_#{i}"], :quantidade => params["quantidade_acompanhamento_#{i}"])
        #acompanhamento_novo.last.acompanhamento.decrescer(acompanhamento_novo.last.quantidade)        
      end
    end
      acompanhamentos_removidos = pa - acompanhamento_editado
      acompanhamentos_removidos = acompanhamentos_removidos - acompanhamento_novo
      acompanhamentos_removidos.each do |acompanhamento_removido|
        acompanhamento_removido.acompanhamento.acrescer(acompanhamento_removido.quantidade)
        acomp = Acompanhamento.find_by_id(acompanhamento_removido.acompanhamento_id)
        @pedido.pedidos_acompanhamentos.delete(acompanhamento_removido)
        @pedido.acompanhamentos.delete(acomp)
        acompanhamento_removido.destroy
      end

    proteina_novo = []
    pc = @pedido.pedidos_proteinas
    proteina_editado = []
    proteinas = Proteina.where(:disponibilidade => true).count #tem que ver outra quantidade pra colocar, pq senao pode dar ruim, caso alguma proteina seja desativada.
    #proteinas = @pedido.pedidos_proteinas.count talvez seja esse o tamanho ideal... mas vamos ver... pensar
    for i in 0..proteinas do
      proteina=nil
      if  !params["proteina_#{i}"].blank?
        proteina = Proteina.find(params["proteina_#{i}"])
      end
      if (( @pedido.proteinas.include? proteina) && ( !params["proteina_#{i}"].blank?) && (params["quantidade_proteina_#{i}"].to_i != @pedido.pedidos_proteinas.find_by_proteina_id(proteina.id).quantidade) && (@flag_situacao != 1))
        atualiza_proteina = @pedido.pedidos_proteinas.find_by_proteina_id(params["proteina_#{i}"])
        proteina.acrescer(atualiza_proteina.quantidade) #Aqui adiciona o que tinha ficado no pedido antes de ser editado.
        atualiza_proteina.quantidade = params["quantidade_proteina_#{i}"].to_i
        proteina_editado << atualiza_proteina # Ver se está adicionando duas instancias de pedidos_proteinas no vetor 
        atualiza_proteina.save
      elsif (( @pedido.proteinas.include? proteina) && ( !params["proteina_#{i}"].blank?) && (params["quantidade_proteina_#{i}"].to_i == @pedido.pedidos_proteinas.find_by_proteina_id(proteina.id).quantidade) && (@flag_situacao != 1))
        atualiza_proteina = @pedido.pedidos_proteinas.find_by_proteina_id(params["proteina_#{i}"])
        proteina.acrescer(atualiza_proteina.quantidade) #Aqui adiciona o que tinha ficado no pedido antes de ser editado.
        proteina_editado << atualiza_proteina
        # Aqui acho que poderia não fazer nada...
      elsif (( !params["proteina_#{i}"].blank?) && ( !params["quantidade_proteina_#{i}"].nil?))
        proteina_novo << @pedido.pedidos_proteinas.create!(:proteina_id => params["proteina_#{i}"], :quantidade => params["quantidade_proteina_#{i}"])
        #proteina_novo.last.proteina.decrescer(proteina_novo.last.quantidade)
        # Cria nova proteina adicionada no pedido e remove a quantidade da qtd disponivel no cardapio.
      end
    end
    #### Removendo proteinas após edição ####
    proteinas_removidos = pc - proteina_editado
    proteinas_removidos = proteinas_removidos - proteina_novo
    proteinas_removidos.each do |proteina_removido|
      proteina_removido.proteina.acrescer(proteina_removido.quantidade)
      prote = Proteina.find_by_id(proteina_removido.proteina_id)
      @pedido.pedidos_proteinas.delete(proteina_removido)
      @pedido.proteinas.delete(prote)
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
      if (( @pedido.guarnicoes.include? guarnicao) && ( !params["guarnicao_#{i}"].blank?) && (params["quantidade_guarnicao_#{i}"].to_i != @pedido.pedidos_guarnicoes.find_by_guarnicao_id(guarnicao.id).quantidade) && (@flag_situacao != 1))
        atualiza_guarnicao = @pedido.pedidos_guarnicoes.find_by_guarnicao_id(params["guarnicao_#{i}"])
        guarnicao.acrescer(atualiza_guarnicao.quantidade)
        atualiza_guarnicao.quantidade = params["quantidade_guarnicao_#{i}"].to_i
        guarnicao_editado << atualiza_guarnicao
        atualiza_guarnicao.save
      elsif (( @pedido.guarnicoes.include? guarnicao) && ( !params["guarnicao_#{i}"].blank?) && (params["quantidade_guarnicao_#{i}"].to_i == @pedido.pedidos_guarnicoes.find_by_guarnicao_id(guarnicao.id).quantidade) && (@flag_situacao != 1))
        atualiza_guarnicao = @pedido.pedidos_guarnicoes.find_by_guarnicao_id(params["guarnicao_#{i}"])
        guarnicao.acrescer(atualiza_guarnicao.quantidade)
        guarnicao_editado << atualiza_guarnicao
      elsif (( !params["guarnicao_#{i}"].blank?) && ( !params["quantidade_guarnicao_#{i}"].nil?))
        guarnicao_novo << @pedido.pedidos_guarnicoes.create!(:guarnicao_id => params["guarnicao_#{i}"], :quantidade => params["quantidade_guarnicao_#{i}"])
        #guarnicao_novo.last.guarnicao.decrescer(guarnicao_novo.last.quantidade)
      end
    end
    #### Removendo proteinas após edição ####
    guarnicoes_removidos = pc - guarnicao_editado
    guarnicoes_removidos = guarnicoes_removidos - guarnicao_novo
    guarnicoes_removidos.each do |guarnicao_removido|
      guarnicao_removido.guarnicao.acrescer(guarnicao_removido.quantidade)
      guarni = Guarnicao.find_by_id(guarnicao_removido.guarnicao_id)
      @pedido.pedidos_guarnicoes.delete(guarnicao_removido)
      @pedido.guarnicoes.delete(guarni)
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
      if (( @pedido.saladas.include? salada) && ( !params["salada_#{i}"].blank?) && (params["quantidade_salada_#{i}"].to_i != @pedido.pedidos_saladas.find_by_salada_id(salada.id).quantidade) && (@flag_situacao != 1))
        atualiza_salada = @pedido.pedidos_saladas.find_by_salada_id(params["salada_#{i}"])
        salada.acrescer(atualiza_salada.quantidade)
        atualiza_salada.quantidade = params["quantidade_salada_#{i}"].to_i
        salada_editado << atualiza_salada
        atualiza_salada.save
      elsif (( @pedido.saladas.include? salada) && ( !params["salada_#{i}"].blank?) && (params["quantidade_salada_#{i}"].to_i == @pedido.pedidos_saladas.find_by_salada_id(salada.id).quantidade) && (@flag_situacao != 1))
        atualiza_salada = @pedido.pedidos_saladas.find_by_salada_id(params["salada_#{i}"])
        salada.acrescer(atualiza_salada.quantidade)
        salada_editado << atualiza_salada
      elsif (( !params["salada_#{i}"].blank?) && ( !params["quantidade_salada_#{i}"].nil?))
        salada_novo << @pedido.pedidos_saladas.create!(:salada_id => params["salada_#{i}"], :quantidade => params["quantidade_salada_#{i}"])
        #salada_novo.last.salada.decrescer(salada_novo.last.quantidade)
      end
    end
    #### Removendo proteinas após edição ####
    saladas_removidos = pc - salada_editado
    saladas_removidos = saladas_removidos - salada_novo
    saladas_removidos.each do |salada_removido|
      salada_removido.salada.acrescer(salada_removido.quantidade)
      salad = Salada.find_by_id(salada_removido.salada_id)
      @pedido.pedidos_saladas.delete(salada_removido)
      @pedido.saladas.delete(salad)
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
      if (( @pedido.bebidas.include? bebida) && ( !params["bebida_#{i}"].blank?) && (params["quantidade_bebida_#{i}"].to_i != @pedido.pedidos_bebidas.find_by_bebida_id(bebida.id).quantidade) && (@flag_situacao != 1))
        atualiza_bebida = @pedido.pedidos_bebidas.find_by_bebida_id(params["bebida_#{i}"])
        bebida.acrescer(atualiza_bebida.quantidade)
        atualiza_bebida.quantidade = params["quantidade_bebida_#{i}"].to_i
        bebida_editado << atualiza_bebida
        atualiza_bebida.save
      elsif (( @pedido.bebidas.include? bebida) && ( !params["bebida_#{i}"].blank?) && (params["quantidade_bebida_#{i}"].to_i == @pedido.pedidos_bebidas.find_by_bebida_id(bebida.id).quantidade) && (@flag_situacao != 1))
        atualiza_bebida = @pedido.pedidos_bebidas.find_by_bebida_id(params["bebida_#{i}"])
        bebida.acrescer(atualiza_bebida.quantidade)
        bebida_editado << atualiza_bebida
      elsif (( !params["bebida_#{i}"].blank?) && ( !params["quantidade_bebida_#{i}"].nil?))
        bebida_novo << @pedido.pedidos_bebidas.create!(:bebida_id => params["bebida_#{i}"], :quantidade => params["quantidade_bebida_#{i}"])
        #bebida_novo.last.bebida.decrescer(bebida_novo.last.quantidade)
      end
    end
    #### Removendo proteinas após edição ####
    bebidas_removidos = pc - bebida_editado
    bebidas_removidos = bebidas_removidos - bebida_novo
    bebidas_removidos.each do |bebida_removido|
      bebida_removido.bebida.acrescer(bebida_removido.quantidade)
      bebid = Bebida.find_by_id(bebida_removido.bebida_id)
      @pedido.pedidos_bebidas.delete(bebida_removido)
      @pedido.bebidas.delete(bebid)
      bebida_removido.destroy
    end
    ##################### Fim bebidas removidos #####################


    sobremesa_novo = []
    pc = @pedido.pedidos_sobremesas
    sobremesa_editado = []
    sobremesas = Sobremesa.where(:disponibilidade => true).count
    for i in 0..sobremesas do
      sobremesa=nil
      if  !params["sobremesa_#{i}"].blank?
        sobremesa = Sobremesa.find(params["sobremesa_#{i}"])
      end
      if (( @pedido.sobremesas.include? sobremesa) && ( !params["sobremesa_#{i}"].blank?) && (params["quantidade_sobremesa_#{i}"].to_i != @pedido.pedidos_sobremesas.find_by_sobremesa_id(sobremesa.id).quantidade) && (@flag_situacao != 1))
        atualiza_sobremesa = @pedido.pedidos_sobremesas.find_by_sobremesa_id(params["sobremesa_#{i}"])
        sobremesa.acrescer(atualiza_sobremesa.quantidade)
        atualiza_sobremesa.quantidade = params["quantidade_sobremesa_#{i}"].to_i
        sobremesa_editado << atualiza_sobremesa
        atualiza_sobremesa.save
      elsif (( @pedido.sobremesas.include? sobremesa) && ( !params["sobremesa_#{i}"].blank?) && (params["quantidade_sobremesa_#{i}"].to_i == @pedido.pedidos_sobremesas.find_by_sobremesa_id(sobremesa.id).quantidade) && (@flag_situacao != 1))
        atualiza_sobremesa = @pedido.pedidos_sobremesas.find_by_sobremesa_id(params["sobremesa_#{i}"])
        sobremesa_editado << atualiza_sobremesa
      elsif (( !params["sobremesa_#{i}"].blank?) && ( !params["quantidade_sobremesa_#{i}"].nil?))
        sobremesa_novo << @pedido.pedidos_sobremesas.create!(:sobremesa_id => params["sobremesa_#{i}"], :quantidade => params["quantidade_sobremesa_#{i}"])
        #sobremesa_novo.last.sobremesa.decrescer(sobremesa_novo.last.quantidade)
      end
    end
    #### Removendo sobremesas após edição ####
    sobremesas_removidos = pc - sobremesa_editado
    sobremesas_removidos = sobremesas_removidos - sobremesa_novo
    sobremesas_removidos.each do |sobremesa_removido|
      sobremesa_removido.sobremesa.acrescer(sobremesa_removido.quantidade)
      sobremes = Sobremesa.find_by_id(sobremesa_removido.sobremesa_id)
      @pedido.pedidos_sobremesas.delete(sobremesa_removido)
      @pedido.sobremesas.delete(sobremes)
      sobremesa_removido.destroy
    end

    # debugger

#    puts "teste"
    ##################### Fim sobremesas removidos #####################

    # proteinas = Proteina.where(:disponibilidade => true, :tipo => "Carne").count
    # for i in 0...proteinas do
    #   if !params["proteina_#{i}"].blank?
    #     @pedido.pedidos_proteinas.new(:proteina_id => params["proteina_#{i}"], :quantidade => params["quantidade_#{i}"])
    #   end
    # end
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

  def search
    @pedidos = Pedidos.search params[:empresa]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pedido
      @pedido = Pedido.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pedido_params
      #debugger
      params.require(:pedido).permit(:proteinas, :bebidas, :sobremesas, :acompanhamentos, :guarnicoes, :saladas,:valor, :id, :cliente_id, :situacao, :conta, :observacao)
    end
end
