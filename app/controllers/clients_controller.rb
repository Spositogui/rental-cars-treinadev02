class ClientsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_client, only: [:show]

  def index
    @clients = Client.all
  end

  def show; end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      flash[:notice] = 'Cliente criado com sucesso'
      redirect_to @client
    else
      render :new
    end
  end

  private
  def client_params
    params.require(:client).permit(:name, :document, :email)
  end

  def set_client  
    @client = Client.find(params[:id])
  end
end