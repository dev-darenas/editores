require "application_system_test_case"

class LoadWaresTest < ApplicationSystemTestCase
  setup do
    @load_ware = load_wares(:one)
  end

  test "visiting the index" do
    visit load_wares_url
    assert_selector "h1", text: "Load Wares"
  end

  test "creating a Load ware" do
    visit load_wares_url
    click_on "New Load Ware"

    fill_in "Quantity", with: @load_ware.quantity
    fill_in "User", with: @load_ware.user_id
    fill_in "Ware", with: @load_ware.ware_id
    click_on "Create Load ware"

    assert_text "Load ware was successfully created"
    click_on "Back"
  end

  test "updating a Load ware" do
    visit load_wares_url
    click_on "Edit", match: :first

    fill_in "Quantity", with: @load_ware.quantity
    fill_in "User", with: @load_ware.user_id
    fill_in "Ware", with: @load_ware.ware_id
    click_on "Update Load ware"

    assert_text "Load ware was successfully updated"
    click_on "Back"
  end

  test "destroying a Load ware" do
    visit load_wares_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Load ware was successfully destroyed"
  end
end
