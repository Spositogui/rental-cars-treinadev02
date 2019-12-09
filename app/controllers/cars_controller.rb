class CarsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin
  before_action :set_car, only: [:show, :edit, :update]

  def index
    @cars = Car.all
  end

  def show; end

  def new
    @car = Car.new
    set_objects_params
  end

  def edit
    set_objects_params
  end

  def create
    @car = Car.new(car_params)
    if @car.save
      flash[:notice] = 'Carro criado com sucesso'
      redirect_to @car
    else
      set_objects_params
      render :new
    end
  end

  def update
    if @car.update(car_params)
      flash[:notice] = 'Carro editado com sucesso'
      redirect_to @car
    else
      set_objects_params
      render :edit
    end
  end

  private

  def car_params
    params.require(:car).permit(:license_plate, :color,
                                :car_model_id, :mileage, 
                                :subsidiary_id)
  end

  def set_car
    @car = Car.find(params[:id])
  end

  def set_objects_params
    @car_models = CarModel.all
    @subsidiaries = Subsidiary.all
  end
end