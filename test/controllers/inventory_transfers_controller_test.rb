require 'test_helper'

class InventoryTransfersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @inventory_transfer = inventory_transfers(:one)
  end

  test "should get index" do
    get inventory_transfers_url
    assert_response :success
  end

  test "should get new" do
    get new_inventory_transfer_url
    assert_response :success
  end

  test "should create inventory_transfer" do
    assert_difference('InventoryTransfer.count') do
      post inventory_transfers_url, params: { inventory_transfer: { date: @inventory_transfer.date, observations: @inventory_transfer.observations, product_id: @inventory_transfer.product_id, quantity: @inventory_transfer.quantity, recipient_id: @inventory_transfer.recipient_id, sender_id: @inventory_transfer.sender_id } }
    end

    assert_redirected_to inventory_transfer_url(InventoryTransfer.last)
  end

  test "should show inventory_transfer" do
    get inventory_transfer_url(@inventory_transfer)
    assert_response :success
  end

  test "should get edit" do
    get edit_inventory_transfer_url(@inventory_transfer)
    assert_response :success
  end

  test "should update inventory_transfer" do
    patch inventory_transfer_url(@inventory_transfer), params: { inventory_transfer: { date: @inventory_transfer.date, observations: @inventory_transfer.observations, product_id: @inventory_transfer.product_id, quantity: @inventory_transfer.quantity, recipient_id: @inventory_transfer.recipient_id, sender_id: @inventory_transfer.sender_id } }
    assert_redirected_to inventory_transfer_url(@inventory_transfer)
  end

  test "should destroy inventory_transfer" do
    assert_difference('InventoryTransfer.count', -1) do
      delete inventory_transfer_url(@inventory_transfer)
    end

    assert_redirected_to inventory_transfers_url
  end
end
