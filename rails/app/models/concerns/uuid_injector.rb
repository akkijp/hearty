# see: https://qiita.com/HeRo/items/2816e27fb3066db6c4e6
module UuidInjector
  extend ActiveSupport::Concern

  def self.included(klass)
    klass.before_create :fill_uuid
  end

  def fill_uuid
    self.uid = loop do
      uuid = SecureRandom.uuid
      break uuid unless self.class.exists?(uid: uuid)
    end
  end
end
