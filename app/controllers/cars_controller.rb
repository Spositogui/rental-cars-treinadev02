class CarsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin
  
  def index
    @cars = Car.all
  end

  def show
    @car = Car.find(params[:id])
  end

  def new
    @car = Car.new
    @car_models = CarModel.all
    @subsidiaries = Subsidiary.all
  end

  def create
    @car = Car.new(params.require(:car).permit(:license_plate, :color,
                                               :car_model_id, :mileage, 
                                               :subsidiary_id))
    if @car.save
      flash[:notice] = 'Carro criado com sucesso'
      redirect_to @car
    else
      @car_models = CarModel.all
      @subsidiaries = Subsidiary.all
      render :new
    end
  end
end