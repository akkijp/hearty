class Client::Auth::OauthsController < Client::BaseController
  # skip_before_action :require_login

  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]
    if provider == 'line'
      callback_with_line
    else
      callback_with_default
    end
  end

  private

  def callback_with_default
    if (@user = login_from(provider))
      pp 'ログイン処理'
      redirect_to root_path, success: 'ログインしました'
    else
      pp 'ログイン&ユーザー作成処理'
      begin
        pp params
        @user = create_from(provider)
        reset_session
        auto_login(@user)
        redirect_to root_path, success: 'ログインしました'
      rescue StandardError
        redirect_to root_path, danger: 'ログインに失敗しました'
      end
    end
  end

  def callback_with_line
    binding.pry
  end
end
