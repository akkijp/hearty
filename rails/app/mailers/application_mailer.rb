class ApplicationMailer < ActionMailer::Base
  default from: "パートナーカウンセリング・AI <info@hearty.love>"
  layout "mailer"

  SERVICE_NAME = "ペンペン"

  def test_mail(email)
    mail(to: email, subject: "【#{SERVICE_NAME}】Test Mail")
  end
end
