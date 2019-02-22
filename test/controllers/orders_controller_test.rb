require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order = orders(:one)
  end

  test "should get index" do
    get orders_url
    assert_response :success
  end

  test "should get new" do
    get new_order_url
    assert_response :success
  end

  test "should create order" do
    assert_difference('Order.count') do
      post orders_url, params: { order: { address_one: @order.address_one, address_two: @order.address_two, city_id: @order.city_id, client_name: @order.client_name, client_phone: @order.client_phone, code: @order.code, date: @order.date, department_id: @order.department_id, familiar_reference: @order.familiar_reference, familiar_reference_phone: @order.familiar_reference_phone, latitude: @order.latitude, longitude: @order.longitude, neighborhood_address_one: @order.neighborhood_address_one, neighborhood_address_two: @order.neighborhood_address_two, observations: @order.observations, payment_date: @order.payment_date, personal_reference: @order.personal_reference, personal_reference_phone: @order.personal_reference_phone, quota_amount: @order.quota_amount, quota_quantity: @order.quota_quantity, spouse_name: @order.spouse_name, spouse_phone: @order.spouse_phone, total_paid: @order.total_paid } }
    end

    assert_redirected_to order_url(Order.last)
  end

  test "should show order" do
    get order_url(@order)
    assert_response :success
  end

  test "should get edit" do
    get edit_order_url(@order)
    assert_response :success
  end

  test "should update order" do
    patch order_url(@order), params: { order: { address_one: @order.address_one, address_two: @order.address_two, city_id: @order.city_id, client_name: @order.client_name, client_phone: @order.client_phone, code: @order.code, date: @order.date, department_id: @order.department_id, familiar_reference: @order.familiar_reference, familiar_reference_phone: @order.familiar_reference_phone, latitude: @order.latitude, longitude: @order.longitude, neighborhood_address_one: @order.neighborhood_address_one, neighborhood_address_two: @order.neighborhood_address_two, observations: @order.observations, payment_date: @order.payment_date, personal_reference: @order.personal_reference, personal_reference_phone: @order.personal_reference_phone, quota_amount: @order.quota_amount, quota_quantity: @order.quota_quantity, spouse_name: @order.spouse_name, spouse_phone: @order.spouse_phone, total_paid: @order.total_paid } }
    assert_redirected_to order_url(@order)
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete order_url(@order)
    end

    assert_redirected_to orders_url
  end
end
