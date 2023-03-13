require "test_helper"

class Client::OauthsControllerTest < ActionDispatch::IntegrationTest
  test "should get oauth" do
    get client_oauths_oauth_url
    assert_response :success
  end

  test "should get callback" do
    get client_oauths_callback_url
    assert_response :success
  end
end
