# see: https://qiita.com/HeRo/items/2816e27fb3066db6c4e6
module AccountTemporaryEmail
  extend ActiveSupport::Concern

  EXPIRES_TIME = 24.hours

  included do
    before_save :temporary_email_processing

    # 一時保存したメールアドレスが有効かチェックする
    def temporary_email_is_valid?
      self.temporary_email_expires_at.present? && self.temporary_email_expires_at > Time.current
    end

    # 一時保存したメールアアドレスに変更する
    def change_email_from_temporary!
      self.email = self.temporary_email
      self.temporary_email_expires_at = nil
      self.temporary_email = nil
      self.save
    end

    # 一時保存したメールアドレスが期限を迎えている場合削除する
    def cleanup_temporary_email!
      unless self.temporary_email_is_valid?
        self.temporary_email_expires_at = nil
        self.temporary_email = nil
        self.save
      end
    end

    # 一時保存したメールアドレスの有効期限を延長する
    def update_temporary_email_expires!
      if self.temporary_email.present?
        self.temporary_email_expires_at = Time.current + EXPIRES_TIME
        self.save
      end
    end

    private
      def temporary_email_processing
        if self.temporary_email.nil? || (self.temporary_email_expires_at.present? && self.temporary_email_expires_at < Time.current)
          self.temporary_email = nil
          self.temporary_email_token = nil
          self.temporary_email_expires_at = nil
        elsif temporary_email_changed?
          self.temporary_email_token = SecureRandom.hex(10)
          self.temporary_email_expires_at = Time.current + EXPIRES_TIME
        end
      end
  end
end
