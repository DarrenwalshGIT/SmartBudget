require "application_system_test_case"

class HomesTest < ApplicationSystemTestCase
  test "visiting the home page" do
    visit "/home/index"

    assert_selector "body"
  end
end
