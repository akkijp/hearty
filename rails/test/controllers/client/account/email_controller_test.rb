require "test_helper"

class Client::Account::EmailControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get client_account_email_show_url
    assert_response :success
  end
end
