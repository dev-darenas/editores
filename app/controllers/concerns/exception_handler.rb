# app/controllers/concerns/exception_handler.rb
module ExceptionHandler
  # provides the more graceful `included` method
  extend ActiveSupport::Concern

  # Define custom error subclasses - rescue catches `StandardErrors`
  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end

  class FarFromClient < StandardError; end

  class OrderAlreadyTaken < StandardError; end

  # class TransferenceSameAccount < StandardError; end
  # class InsufficientBalance < StandardError; end
  # class InsufficientAmount < StandardError; end
  # class BudgetAlreadyExist < StandardError; end
  # class BudgetSameYear < StandardError; end
  # class BudgetSameMonth < StandardError; end
  # class BudgetMonthOrder < StandardError; end
  # class BudgetPreviousEmpty < StandardError; end
  
  # class UserIsNotAdmin < StandardError; end
  # class UserIsNotValid < StandardError; end
  # class UserHasNotDefaultAccount < StandardError; end
  # class CategoryAndConceptDoesNotMatch < StandardError; end

  included do

    # Define custom handlers
    rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from ExceptionHandler::MissingToken, with: :four_twenty_two
    rescue_from ExceptionHandler::InvalidToken, with: :four_twenty_two

    rescue_from ExceptionHandler::FarFromClient, with: :far_from_client

    rescue_from ExceptionHandler::OrderAlreadyTaken, with: :order_already_taken

    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ message: e.message }, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      message = get_message(e.message)
      json_response({ message: message }, :unprocessable_entity)
    end
  end

  private

  # JSON response with message; Status code 422 - unprocessable entity
  def four_twenty_two(e)
    json_response({ message: e.message }, :unprocessable_entity)
  end

  # JSON response with message; Status code 401 - Unauthorized
  def unauthorized_request(e)
    json_response({ message: e.message }, :unauthorized)
  end

  def far_from_client(e)
    json_response({ message: e.message}, :unprocessable_entity)
  end

  def order_already_taken(e)
    json_response({ message: e.message}, :unprocessable_entity)
  end

  def get_message(error)
    case error
    when 'Validation failed: Name has already been taken'
      'Este nombre ya existe'
    end
  end
end
