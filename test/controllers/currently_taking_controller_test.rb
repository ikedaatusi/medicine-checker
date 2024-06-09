require "test_helper"

class CurrentlyTakingControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get currently_taking_index_url
    assert_response :success
  end

  test "should get show" do
    get currently_taking_show_url
    assert_response :success
  end

  test "should get new" do
    get currently_taking_new_url
    assert_response :success
  end

  test "should get edit" do
    get currently_taking_edit_url
    assert_response :success
  end
end
