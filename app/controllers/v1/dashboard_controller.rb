module V1
  class DashboardController < ApiController

    def index
      pending  = current_user.orders.where(payment_date: Date.today, status: :pending).sum(&:quota_amount)
      collected = current_user.orders.map { |o| o.payments.where(date: Date.today).sum(&:total_paid) }.inject(0){|sum,x| sum + x }
      json_response({
        pending: pending,
        collected: collected
      })
    end
  end
end
