namespace :order do
  desc 'Update orders total'
  task updates: :environment do
    Order.all.each do |order|
      p " order #{order.code}"
      order.update!(total: order.quota_quantity * order.quota_amount)
      order.update_total_payment
    end
  end
end
