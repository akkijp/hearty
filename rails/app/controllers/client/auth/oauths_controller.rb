class Client::OauthsController < Client::BaseController
  # skip_before_action :require_login

  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]
    if (@user = login_from(provider))
      redirect_to root_path, success: 'ログインしました'
    else
      begin
        @user = create_from(provider)
        reset_session
        auto_login(@user)
        redirect_to root_path, success: 'ログインしました'
      rescue StandardError
        redirect_to root_path, danger: 'ログインに失敗しました'
      end
    end
  end
end
