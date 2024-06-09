require "test_helper"

class CurrentlyControllerTest < ActionDispatch::IntegrationTest
  test "should get taking" do
    get currently_taking_url
    assert_response :success
  end

  test "should get index" do
    get currently_index_url
    assert_response :success
  end

  test "should get show" do
    get currently_show_url
    assert_response :success
  end

  test "should get new" do
    get currently_new_url
    assert_response :success
  end

  test "should get edit" do
    get currently_edit_url
    assert_response :success
  end
end
