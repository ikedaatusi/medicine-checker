require "test_helper"

class AlreadyTakenControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get already_taken_index_url
    assert_response :success
  end

  test "should get show" do
    get already_taken_show_url
    assert_response :success
  end

  test "should get new" do
    get already_taken_new_url
    assert_response :success
  end

  test "should get edit" do
    get already_taken_edit_url
    assert_response :success
  end
end
