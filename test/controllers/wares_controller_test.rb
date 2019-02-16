require 'test_helper'

class WaresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ware = wares(:one)
  end

  test "should get index" do
    get wares_url
    assert_response :success
  end

  test "should get new" do
    get new_ware_url
    assert_response :success
  end

  test "should create ware" do
    assert_difference('Ware.count') do
      post wares_url, params: { ware: { name: @ware.name, price: @ware.price, quantity: @ware.quantity, reference: @ware.reference } }
    end

    assert_redirected_to ware_url(Ware.last)
  end

  test "should show ware" do
    get ware_url(@ware)
    assert_response :success
  end

  test "should get edit" do
    get edit_ware_url(@ware)
    assert_response :success
  end

  test "should update ware" do
    patch ware_url(@ware), params: { ware: { name: @ware.name, price: @ware.price, quantity: @ware.quantity, reference: @ware.reference } }
    assert_redirected_to ware_url(@ware)
  end

  test "should destroy ware" do
    assert_difference('Ware.count', -1) do
      delete ware_url(@ware)
    end

    assert_redirected_to wares_url
  end
end
