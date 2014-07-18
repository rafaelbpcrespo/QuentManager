class ArrozesController < ApplicationController
  before_action :set_arroz, only: [:show, :edit, :update, :destroy]

  # GET /arrozes
  # GET /arrozes.json
  def index
    @arrozes = Arroz.all
  end

  # GET /arrozes/1
  # GET /arrozes/1.json
  def show
  end

  # GET /arrozes/new
  def new
    @arroz = Arroz.new
  end

  # GET /arrozes/1/edit
  def edit
  end

  # POST /arrozes
  # POST /arrozes.json
  def create
    @arroz = Arroz.new(arroz_params)

    respond_to do |format|
      if @arroz.save
        format.html { redirect_to @arroz, notice: 'Arroz was successfully created.' }
        format.json { render action: 'show', status: :created, location: @arroz }
      else
        format.html { render action: 'new' }
        format.json { render json: @arroz.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /arrozes/1
  # PATCH/PUT /arrozes/1.json
  def update
    respond_to do |format|
      if @arroz.update(arroz_params)
        format.html { redirect_to @arroz, notice: 'Arroz was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @arroz.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /arrozes/1
  # DELETE /arrozes/1.json
  def destroy
    @arroz.destroy
    respond_to do |format|
      format.html { redirect_to arrozes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_arroz
      @arroz = Arroz.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def arroz_params
      params.require(:arroz).permit(:nome, :disponibilidade)
    end
end
