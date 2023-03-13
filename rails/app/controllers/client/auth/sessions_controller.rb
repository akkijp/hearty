class Client::Auth::SessionsController < Client::BaseController
  # skip_before_action :require_login_for_user, only: [:new, :create]
  # layout 'users/layouts/base_login'
  before_action :set_redirect_url

  def new
    return redirect_to(mypage_root_path) if logged_in?
  end

  def create
    alert_message = 'メールアドレスかパスワードが間違っています'
    notice_msaaage = 'ログインしました'

    # ユーザー情報取得
    @account = Account.kept.find_by(email: params[:email])
    
    # チェック
    if @account.blank? || !@account.is_user
      flash[:alert] = alert_message
      render :new
      return
    end

    # ログイン行使
    if @account.valid_password?(params[:password])
      @account.remember_me! unless params[:remember] == '0'
      auto_login(@account)
      flash[:notice] = notice_msaaage

      redirect_to @redirect_url
      return
    else
      flash[:alert] = alert_message
      @email = params[:email]
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path
  end

  private
    def set_redirect_url
      @redirect_url = params[:redirect_to].present? ? params[:redirect_to] : root_path
    end
end
