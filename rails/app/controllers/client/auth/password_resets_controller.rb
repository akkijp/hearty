class Client::Auth::PasswordResetsController < Client::BaseController
  def new
    @account = Account.new
    flash.discard
  end

  def create
    email = account_create_params[:email]
    @account = Account.kept.joins(:user).find_by(email: email)
    if @account
      @account.deliver_reset_password_instructions! # パスワードリセット時のメール送信
    end
    if params[:resend].present?
      flash[:notice] = "メールを再送信しました"
    end
    redirect_to thanks_create_users_auth_password_resets_path(email: email)
  end

  def thanks_create
    @account = Account.new
    @noindex = true
  end

  def edit
    @account = Account.load_from_reset_password_token(params[:id])
    return redirect_to new_users_auth_password_reset_path if @account.blank?
  end

  def update
    @account = Account.load_from_reset_password_token(params[:id])
    return redirect_to new_users_auth_password_reset_path if @account.blank?

    @account.attributes = account_update_params
    if @account.save
      @account.change_password!(params[:password])
      redirect_to thanks_update_users_auth_password_resets_path(email: @account.email)
    else
      render :edit
    end
  end

  def thanks_update
  end

  private
    def account_create_params
      params.require(:account).permit(
        :email
      )
    end

    def account_update_params
      params.require(:account).permit(
        :password,
        :password_confirmation
      )
    end
end
