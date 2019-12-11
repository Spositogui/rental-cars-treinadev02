class RentalsController < ApplicationController
  before_action :authenticate_user!

  def index
    @rentals = Rental.all
    @search_result = nil
  end
  
  def show
    @rental = Rental.find(params[:id])
  end

  def new
    @rental = Rental.new
    @clients = Client.all
    @car_categories = CarCategory.all
  end

  def create
    @rental = Rental.new(params.require(:rental).permit(:start_date, :end_date,
                                                        :client_id, :car_category_id))
    if @rental.save
      redirect_to @rental, notice: 'Locação agendada com sucesso'
    else
      @clients = Client.all
      @car_categories = CarCategory.all
      render :new
    end
  end

  def search
    @search_result = Rental.find_by reservation_code: params[:q]
    render :index
  end
end