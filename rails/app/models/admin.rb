class Admin < ApplicationRecord
  has_secure_password
  include Discard::Model

  # メールアドレスの正規表現
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  # 大小英数字 8文字以上32文字以下
  VALID_PASSWORD_REGEX = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,32}$/

  before_save { self.email = email.downcase }

  validates :status, presence: true
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 8, maximum: 32 },
                        confirmation: true,
                        if: -> { new_record? || changes[:password_digest] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:password_digest] }
  validate :pwned_validate, if: -> { new_record? || changes[:password_digest] }

  enum status: {
    pending: 0,
    active: 1,
    suspend: 2
  }, _prefix: true

  scope :actives, -> {
    kept.where(status: :active)
  }

  private
    def pwned_validate
      return if password.blank?
      password_sha256 = Digest::SHA256.hexdigest(password)
      if Pwned.find_by(password_sha256: password_sha256).present?
        errors.add(:password, 'は脆弱なパスワードであるため、登録することができません')
      end
    end
end
