class SubsidiariesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin
  before_action :set_subsidiary, only: [:show, :edit, :update, :destroy]
  
  def index
    @subsidiaries = Subsidiary.all
  end

  def show; end

  def new
    @subsidiary = Subsidiary.new
  end

  def edit; end
  
  def create
    @subsidiary = Subsidiary.new(subsidiary_params)
    if @subsidiary.save
      redirect_to @subsidiary
    else
      render :new
    end
  end
  
  def update
    if @subsidiary.update(subsidiary_params)
      redirect_to @subsidiary
    else
      render :edit
    end
  end

  def destroy
    @subsidiary.destroy
    redirect_to subsidiaries_path
  end

  private 
  def subsidiary_params
    params.require(:subsidiary).permit(:name, :cnpj, :address)
  end

  def set_subsidiary
    @subsidiary = Subsidiary.find(params[:id])
  end
end