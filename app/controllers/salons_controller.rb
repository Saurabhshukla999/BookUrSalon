class SalonsController < ApplicationController
  before_action :set_salon, only: [:show, :update, :destroy]

  def index
    salons = Salon.all
    render json: salons
  end

  def show
    render json: @salon
  end

  def create
    salon = Salon.new(salon_params)
    if salon.save
      render json: salon, status: :created
    else
      render json: salon.errors, status: :unprocessable_entity
    end
  end

  def update
    if @salon.update(salon_params)
      render json: @salon
    else
      render json: @salon.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @salon.destroy
    render json: @salon
  end

  private

  def salon_params
    params.require(:salon).permit(:name)
  end

  def set_salon
    @salon = Salon.find(params[:id])
  end
end
