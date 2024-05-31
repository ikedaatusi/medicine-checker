require "test_helper"

class MedicationchecksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get medicationchecks_index_url
    assert_response :success
  end
end
