require "test_helper"

class SpecificCalendarControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get specific_calendar_index_url
    assert_response :success
  end

  test "should get show" do
    get specific_calendar_show_url
    assert_response :success
  end

  test "should get new" do
    get specific_calendar_new_url
    assert_response :success
  end

  test "should get edit" do
    get specific_calendar_edit_url
    assert_response :success
  end
end
