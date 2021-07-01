require "application_system_test_case"

class WowsTest < ApplicationSystemTestCase
  setup do
    @wow = wows(:one)
  end

  test "visiting the index" do
    visit wows_url
    assert_selector "h1", text: "Wows"
  end

  test "creating a Wow" do
    visit wows_url
    click_on "New Wow"

    fill_in "Description", with: @wow.description
    click_on "Create Wow"

    assert_text "Wow was successfully created"
    click_on "Back"
  end

  test "updating a Wow" do
    visit wows_url
    click_on "Edit", match: :first

    fill_in "Description", with: @wow.description
    click_on "Update Wow"

    assert_text "Wow was successfully updated"
    click_on "Back"
  end

  test "destroying a Wow" do
    visit wows_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Wow was successfully destroyed"
  end
end
