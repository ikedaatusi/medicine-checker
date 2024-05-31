require "test_helper"

class DrugConfirmationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get drug_confirmations_index_url
    assert_response :success
  end

  test "should get show" do
    get drug_confirmations_show_url
    assert_response :success
  end

  test "should get new" do
    get drug_confirmations_new_url
    assert_response :success
  end

  test "should get edit" do
    get drug_confirmations_edit_url
    assert_response :success
  end
end
