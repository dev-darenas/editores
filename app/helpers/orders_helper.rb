module OrdersHelper
  def show_status(order)
    case order.status
    when 'pending'
      return 'Pendiente'
    when 'returned'
      return 'Devolucion'
    when 'completed'
      return 'Completado'
    end
  end  
end
