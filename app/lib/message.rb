# app/lib/message.rb
class Message
  def self.not_found(record = 'record')
    "Sorry, #{record} not found."
  end

  def self.invalid_credentials
    'Invalid credentials'
  end

  def self.invalid_token
    'Invalid token'
  end

  def self.missing_token
    'Missing token'
  end

  def self.unauthorized
    'Unauthorized request'
  end

  def self.far_from_client
    'Por Favor dirijase a la dirección del cliente para realizar el respectivo cobro'
  end

  def self.order_already_taken
    'El código del pedido ya ha sido usado, por favor utilice un código diferente'
  end
end