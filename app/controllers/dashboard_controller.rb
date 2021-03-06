class DashboardController < ApplicationController
  def index
    today = Date.today
    first_date = today.beginning_of_month
    last_date = today.end_of_month
    @budget_month = Order.where(status: :pending, payment_date: first_date..last_date).sum(&:quota_amount)
    @budget_today = Order.where(status: :pending, date: today).sum(&:quota_amount)

    @incomes_month = Order.all.map { |o| o.payments.where(date: first_date..last_date).sum(&:total_paid) }.inject(0){|sum,x| sum + x }
    @incomes_today = Order.all.map { |o| o.payments.where(date: today).sum(&:total_paid) }.inject(0){|sum,x| sum + x }


    budget_month_data = Order.where(status: :pending)
                        .order(date: :asc)
                        .group_by { |m| m.date.beginning_of_month.strftime('%b-%Y').downcase }

    @budget_real_data = {
      labels: budget_month_data.map{ |obj| obj[0] },
      datasets: [
        {
            label: "Presupuestado",
            backgroundColor: "rgba(220,220,220,0.2)",
            borderColor: "blue",
            data: budget_month_data.map{ |obj| obj[1].sum(&:quota_amount)}#.map { |o| o.orders_wares.sum(&:total).to_f }}.map { |e| e.inject(0){|sum,x| sum + x }}
        },
        {
            label: "Real",
            backgroundColor: "rgba(151,187,205,0.2)",
            borderColor: "green",
            data: budget_month_data.map{ |obj| {y: obj[1].sum(&:total_paid).to_f}}
        }
      ]
    }
    @options = {}
  end
end
