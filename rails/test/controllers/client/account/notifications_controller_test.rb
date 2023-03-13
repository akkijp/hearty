require "test_helper"

class Client::Account::NotificationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get client_account_notifications_index_url
    assert_response :success
  end
end
