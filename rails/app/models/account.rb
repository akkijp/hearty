class Account < ApplicationRecord
  authenticates_with_sorcery!
  include Discard::Model

  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  # メールアドレスの正規表現
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  # 大小英数字 8文字以上32文字以下
  VALID_PASSWORD_REGEX = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,32}$/

  before_save { self.email = email.downcase }

  validates :email, presence: true, length: { in: 1..250},
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { in: 8..32 },
                       confirmation: true,
                       if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validate :pwned_validate, if: -> { new_record? || changes[:password_digest] }
  validates :temporary_email, format: { with: VALID_EMAIL_REGEX }, allow_nil: true, if: :temporary_email_changed?

  enum status: {
    pending: 0,
    active: 1,
    suspend: 2
  }, _prefix: true

  scope :actives, -> {
    kept
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
