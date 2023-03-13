class User < ApplicationRecord
  authenticates_with_sorcery!
  belongs_to :account
end
