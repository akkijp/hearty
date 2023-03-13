class AccountMailer < ApplicationMailer
  def test_email(account)
    @account = Account.find(account.id)
    mail(to: @account.email, subject: "【#{SERVICE_NAME}】Test Mail")
  end

  # Called by sorcery
  def activation_needed_email(account)
    @account = Account.find(account.id)
    
    if @account.activation_token.present?
      subject = "【#{SERVICE_NAME}】メールの認証を完了させてください"
      mail(to: @account.email, subject: subject)
    end
  end

  # Called by sorcery
  def activation_success_email(account)
    @account = Account.find(account.id)
    mail(to: @account.email, subject: "【#{SERVICE_NAME}】認証が完了しました")
  end

  # Called by sorcery
  def reset_password_email(account)
    @account = Account.find(account.id)
    mail(to: @account.email, subject: "【#{SERVICE_NAME}】パスワードリセットのお知らせ")
  end

  def change_email_activation_needed_email(account)
    @account = Account.find(account.id)
    mail(to: @account.temporary_email, subject: "【#{SERVICE_NAME}】メールアドレス変更手続きのご案内")
  end

  def change_email_activation_success_email(account)
    @account = Account.find(account.id)
    mail(to: @account.temporary_email, subject: "【#{SERVICE_NAME}】メールアドレス変更手続きの完了のお知らせ")
  end

  def change_password_email(account)
    @account = Account.find(account.id)
    mail(to: @account.email, subject: "【#{SERVICE_NAME}】パスワード変更のお知らせ")
  end

  def change_email_notification_email(account)
    @account = Account.find(account.id)
    mail(to: @account.email, subject: "【#{SERVICE_NAME}】メールアドレス変更のお知らせ")
  end

end
