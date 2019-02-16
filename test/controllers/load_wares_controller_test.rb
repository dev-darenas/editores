require 'test_helper'

class LoadWaresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @load_ware = load_wares(:one)
  end

  test "should get index" do
    get load_wares_url
    assert_response :success
  end

  test "should get new" do
    get new_load_ware_url
    assert_response :success
  end

  test "should create load_ware" do
    assert_difference('LoadWare.count') do
      post load_wares_url, params: { load_ware: { quantity: @load_ware.quantity, user_id: @load_ware.user_id, ware_id: @load_ware.ware_id } }
    end

    assert_redirected_to load_ware_url(LoadWare.last)
  end

  test "should show load_ware" do
    get load_ware_url(@load_ware)
    assert_response :success
  end

  test "should get edit" do
    get edit_load_ware_url(@load_ware)
    assert_response :success
  end

  test "should update load_ware" do
    patch load_ware_url(@load_ware), params: { load_ware: { quantity: @load_ware.quantity, user_id: @load_ware.user_id, ware_id: @load_ware.ware_id } }
    assert_redirected_to load_ware_url(@load_ware)
  end

  test "should destroy load_ware" do
    assert_difference('LoadWare.count', -1) do
      delete load_ware_url(@load_ware)
    end

    assert_redirected_to load_wares_url
  end
end
