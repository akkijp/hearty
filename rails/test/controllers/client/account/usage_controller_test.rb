require "test_helper"

class Client::Account::UsageControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get client_account_usage_show_url
    assert_response :success
  end
end
