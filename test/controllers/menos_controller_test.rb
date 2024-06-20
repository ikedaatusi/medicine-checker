require "test_helper"

class MenosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get menos_index_url
    assert_response :success
  end

  test "should get show" do
    get menos_show_url
    assert_response :success
  end

  test "should get new" do
    get menos_new_url
    assert_response :success
  end

  test "should get edit" do
    get menos_edit_url
    assert_response :success
  end
end
