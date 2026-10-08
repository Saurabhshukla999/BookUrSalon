class TestWorker
  include Sidekiq::Job

  def perform(appointment_id)
    appointment = Appointment.find(appointment_id)
    puts "Job running, appointment #{appointment.id} — salon=#{appointment.salon.name}, customer=#{appointment.customer.name}, employee=#{appointment.employee&.name}, service=#{appointment.service&.name} — #{Time.now}"
  end
end
