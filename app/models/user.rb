class User < ApplicationRecord
  has_secure_password
  has_many :user_actions
  has_many :wallets
end
