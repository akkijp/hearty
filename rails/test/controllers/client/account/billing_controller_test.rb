require "test_helper"

class Client::Account::BillingControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get client_account_billing_show_url
    assert_response :success
  end
end
