require "test_helper"

class Client::OverviewControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get client_overview_index_url
    assert_response :success
  end
end
