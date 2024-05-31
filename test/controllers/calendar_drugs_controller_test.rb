require "test_helper"

class CalendarDrugsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get calendar_drugs_index_url
    assert_response :success
  end

  test "should get create" do
    get calendar_drugs_create_url
    assert_response :success
  end

  test "should get new" do
    get calendar_drugs_new_url
    assert_response :success
  end

  test "should get show" do
    get calendar_drugs_show_url
    assert_response :success
  end
end
