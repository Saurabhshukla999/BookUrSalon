class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :update, :destroy]

  def index
    appointments = Appointment.all
    render json: appointments
  end

  def show
    render json: @appointment
  end

  def create
    appointment = Appointment.new(appointment_params)
    if appointment.save
      TestWorker.perform_async(appointment.id)
      render json: appointment, status: :created
    else
      render json: appointment.errors, status: :unprocessable_entity
    end


  end

  def update
    if @appointment.update(appointment_params)
      render json: @appointment
    else
      render json: @appointment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @appointment.destroy
    render json: @appointment
  end

  private

  def appointment_params
    params.require(:appointment).permit(:salon_id, :customer_id, :employee_id, :service_id)
  end

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end
end
