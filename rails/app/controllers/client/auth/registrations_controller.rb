class Client::Auth::RegistrationsController < Client::BaseController
  def new
    redirect_back_or_to(root_path) if logged_in?
  end

  def create
    @account = Account.find_by(email: account_params[:email])
    if @account.present?
      flash[:error] = "メールアドレスは既に登録されています。"
      pp 'メールアドレスは既に登録されています。'
      render plain: 'メールアドレスは既に登録されています。'
      return
    end

    ActiveRecord::Base.transaction do
      @account = Account.new(account_params)
      @account.save!

      @user = User.new(user_params)
      @user.account = @account
      @user.save!

      @user.user_resumes.each do |user_resume|
        user_resume.user = @user
        user_resume.save!
      end
    end

    respond_to do |format|
      format.html { redirect_to thanks_create_users_auth_registrations_path }
      format.json { render json: { status: 'success', location: thanks_create_users_auth_registrations_path } }
    end
  end

  def thanks_create
    @latest_resume = current_user.user.user_resumes.order(work_start_date: :desc).first
    @noindex = true
  end

  def activate
    token = params[:registration_id]
    @account = Account.load_from_activation_token(token)
    @account.activate!
    auto_login(@account)
    redirect_to thanks_activate_users_auth_registrations_path
  end

  def thanks_activate
  end

  private

end