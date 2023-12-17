class User < ApplicationRecord
  validates :email,
            presence: true,
            uniqueness: true,
            format: { with: /\A\S+@\S+\z/ }

  validates :name,
            presence: true,
            uniqueness: true
end
