require "application_system_test_case"

class InventoryTransfersTest < ApplicationSystemTestCase
  setup do
    @inventory_transfer = inventory_transfers(:one)
  end

  test "visiting the index" do
    visit inventory_transfers_url
    assert_selector "h1", text: "Inventory Transfers"
  end

  test "creating a Inventory transfer" do
    visit inventory_transfers_url
    click_on "New Inventory Transfer"

    fill_in "Date", with: @inventory_transfer.date
    fill_in "Observations", with: @inventory_transfer.observations
    fill_in "Product", with: @inventory_transfer.product_id
    fill_in "Quantity", with: @inventory_transfer.quantity
    fill_in "Recipient", with: @inventory_transfer.recipient_id
    fill_in "Sender", with: @inventory_transfer.sender_id
    click_on "Create Inventory transfer"

    assert_text "Inventory transfer was successfully created"
    click_on "Back"
  end

  test "updating a Inventory transfer" do
    visit inventory_transfers_url
    click_on "Edit", match: :first

    fill_in "Date", with: @inventory_transfer.date
    fill_in "Observations", with: @inventory_transfer.observations
    fill_in "Product", with: @inventory_transfer.product_id
    fill_in "Quantity", with: @inventory_transfer.quantity
    fill_in "Recipient", with: @inventory_transfer.recipient_id
    fill_in "Sender", with: @inventory_transfer.sender_id
    click_on "Update Inventory transfer"

    assert_text "Inventory transfer was successfully updated"
    click_on "Back"
  end

  test "destroying a Inventory transfer" do
    visit inventory_transfers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Inventory transfer was successfully destroyed"
  end
end
