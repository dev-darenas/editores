class ReportsController < ApplicationController
  def collection
    format_date = "%Y-%m-%d"
    @start_date = params[:start_date].nil? ? Time.current.beginning_of_month.strftime(format_date)  : params[:start_date]
    @end_date = params[:end_date].nil? ? Time.current.end_of_month.strftime(format_date) : params[:end_date]
    @collector_q = params[:collector].nil? ? nil : params[:collector].first
    @seller_q = params[:seller].nil? ? nil : params[:seller].first
    @company_q = params[:company].nil? ? nil : params[:company].first
    @country_q = params[:country].nil? ? nil : params[:country].first
    @department_q = params[:department].nil? ? nil : params[:department].first
    @city_q = params[:city].nil? ? nil : params[:city].first
    @report = []

    if params[:start_date] && params[:end_date]
      payments = Payment.includes(:order).ransack({
          kind_eq: 0,
          order_enterprise_id_eq: @company_q,
          order_user_id_eq: @seller_q,
          order_collector_id_eq: @collector_q,
          date_gteq: @start_date,
          date_lteq: @end_date,
          order_country_id_eq: @country_q,
          order_department_id_eq: @department_q,
          order_city_id_eq: @city_q
        }).result
      (params[:start_date].to_date..params[:end_date].to_date).each do |date|
        current_payment = payments.where(date: date)
        @report.push(
          OpenStruct.new({
            day: date.strftime('%e'),
            count: Order.find(current_payment.pluck(:order_id)).count,
            count_money: current_payment.sum(:total_paid),
            codes: Order.find(current_payment.pluck(:order_id)).pluck(:code)
          }))
      end
    end


    respond_to do |format|
      format.html
      format.xlsx {
        response.headers[
          'Content-Disposition'
        ] = "attachment; filename=cobranza_#{params[:start_date]}_#{params[:end_date]}.xlsx"
      }
    end
  end

  def collection_pending
    format_date = "%Y-%m-%d"
    @start_date = params[:start_date].nil? ? Time.current.beginning_of_month.strftime(format_date)  : params[:start_date]
    @end_date = params[:end_date].nil? ? Time.current.end_of_month.strftime(format_date) : params[:end_date]
    @collector_q = params[:collector].nil? ? nil : params[:collector].first
    @company_q = params[:company].nil? ? nil : params[:company].first
    @seller_q = params[:seller].nil? ? nil : params[:seller].first
    @country_q = params[:country].nil? ? nil : params[:country].first
    @department_q = params[:department].nil? ? nil : params[:department].first
    @city_q = params[:city].nil? ? nil : params[:city].first
    @report = []

    if params[:start_date] && params[:end_date]
      ordes = Order.pending.ransack({
          user_id_eq: @seller_q,
          enterprise_id_eq: @company_q,
          collector_id_eq: @collector_q,
          payment_date_gteq: @start_date,
          payment_date_lteq: @end_date,
          country_id_eq: @country_q,
          department_id_eq: @department_q,
          city_id_eq: @city_q
        }).result
      (params[:start_date].to_date..params[:end_date].to_date).each do |date|
        current_orders = ordes.where(payment_date: date)
        @report.push(OpenStruct.new({
            day: date.strftime('%e'),
            count: current_orders.count,
            count_money: current_orders.sum(:quota_amount),
            codes: current_orders.pluck(:code)
          }))
      end
    end

    respond_to do |format|
      format.html
      format.xlsx {
        response.headers[
          'Content-Disposition'
        ] = "attachment; filename=cobranza_pendiente_#{params[:start_date]}_#{params[:end_date]}.xlsx"
      }
    end
  end

  def seller
    format_date = "%Y-%m-%d"
    @start_date = params[:start_date].nil? ? Time.current.beginning_of_month.strftime(format_date)  : params[:start_date]
    @end_date = params[:end_date].nil? ? Time.current.end_of_month.strftime(format_date) : params[:end_date]

    @company_q = params[:company].nil? ? nil : params[:company].first
    @seller_q = params[:seller].nil? ? nil : params[:seller].first
    @country_q = params[:country].nil? ? nil : params[:country].first
    @department_q = params[:department].nil? ? nil : params[:department].first
    @city_q = params[:city].nil? ? nil : params[:city].first

    @report = []

    if params[:start_date] && params[:end_date]
      ordes = Order.pending.ransack({
        date_gteq: @start_date,
        date_lteq: @end_date,
        user_id_eq: @seller_q,
        country_id_eq: @country_q,
        department_id_eq: @department_q,
        city_id_eq: @city_q
      }).result

      User.all.each do |user|
        current_order = ordes.where(user_id: user.id)
        @report.push(OpenStruct.new({
            full_name: user.full_name,
            count_seller: current_order.count,
            initial: Payment.where(order_id: current_order.pluck(:id)).sum(:total_paid),
            count_last: ordes.where(user_id: user.id, date: @end_date).count,
            initial_last: Payment.where(order_id: current_order.pluck(:id), order_id: current_order.where(date: @end_date).pluck(:id)).sum(:total_paid),
            codes: ordes.pluck(:code)
          }))
      end
    end
  end
end
