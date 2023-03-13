# see: https://qiita.com/HeRo/items/2816e27fb3066db6c4e6
module AccountWithdrawal
  extend ActiveSupport::Concern

  included do
    # ユーザーを削除
    def withdrawal!
      self.email = "#{self.email}.#{SecureRandom.uuid}.#{Date.today.strftime('%Y%m%d')}.delete"
      ActiveRecord::Base.transaction do
        self.save!
        self.discard!
      end
    end

    # ユーザーを復活
    def unwithdrawal!
      uuid_regex = /\.[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\.\d{8}\.delete/
      self.email = self.email.gsub(uuid_regex, '')
      ActiveRecord::Base.transaction do
        self.save!
        self.undiscard!
      end
    end
  end
end
