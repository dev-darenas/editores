require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  setup do
    @order = orders(:one)
  end

  test "visiting the index" do
    visit orders_url
    assert_selector "h1", text: "Orders"
  end

  test "creating a Order" do
    visit orders_url
    click_on "New Order"

    fill_in "Address one", with: @order.address_one
    fill_in "Address two", with: @order.address_two
    fill_in "City", with: @order.city_id
    fill_in "Client name", with: @order.client_name
    fill_in "Client phone", with: @order.client_phone
    fill_in "Code", with: @order.code
    fill_in "Date", with: @order.date
    fill_in "Department", with: @order.department_id
    fill_in "Familiar reference", with: @order.familiar_reference
    fill_in "Familiar reference phone", with: @order.familiar_reference_phone
    fill_in "Latitude", with: @order.latitude
    fill_in "Longitude", with: @order.longitude
    fill_in "Neighborhood address one", with: @order.neighborhood_address_one
    fill_in "Neighborhood address two", with: @order.neighborhood_address_two
    fill_in "Observations", with: @order.observations
    fill_in "Payment date", with: @order.payment_date
    fill_in "Personal reference", with: @order.personal_reference
    fill_in "Personal reference phone", with: @order.personal_reference_phone
    fill_in "Quota amount", with: @order.quota_amount
    fill_in "Quota quantity", with: @order.quota_quantity
    fill_in "Spouse name", with: @order.spouse_name
    fill_in "Spouse phone", with: @order.spouse_phone
    fill_in "Total paid", with: @order.total_paid
    click_on "Create Order"

    assert_text "Order was successfully created"
    click_on "Back"
  end

  test "updating a Order" do
    visit orders_url
    click_on "Edit", match: :first

    fill_in "Address one", with: @order.address_one
    fill_in "Address two", with: @order.address_two
    fill_in "City", with: @order.city_id
    fill_in "Client name", with: @order.client_name
    fill_in "Client phone", with: @order.client_phone
    fill_in "Code", with: @order.code
    fill_in "Date", with: @order.date
    fill_in "Department", with: @order.department_id
    fill_in "Familiar reference", with: @order.familiar_reference
    fill_in "Familiar reference phone", with: @order.familiar_reference_phone
    fill_in "Latitude", with: @order.latitude
    fill_in "Longitude", with: @order.longitude
    fill_in "Neighborhood address one", with: @order.neighborhood_address_one
    fill_in "Neighborhood address two", with: @order.neighborhood_address_two
    fill_in "Observations", with: @order.observations
    fill_in "Payment date", with: @order.payment_date
    fill_in "Personal reference", with: @order.personal_reference
    fill_in "Personal reference phone", with: @order.personal_reference_phone
    fill_in "Quota amount", with: @order.quota_amount
    fill_in "Quota quantity", with: @order.quota_quantity
    fill_in "Spouse name", with: @order.spouse_name
    fill_in "Spouse phone", with: @order.spouse_phone
    fill_in "Total paid", with: @order.total_paid
    click_on "Update Order"

    assert_text "Order was successfully updated"
    click_on "Back"
  end

  test "destroying a Order" do
    visit orders_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Order was successfully destroyed"
  end
end
