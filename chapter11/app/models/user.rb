require 'bcrypt'

class User < ApplicationRecord
  attr_reader :password

  before_save :downcase_email

  validates :email,
            presence: true,
            uniqueness: true,
            format: { with: /\A\S+@\S+\z/ }

  validates :name,
            presence: true,
            uniqueness: true

  validates :password,
            presence: true,
            confirmation: true,
            if: :password_required?
  
  validates :password_confirmation,
            presence: true,
            if: :password_required?

  def password=(password)
    @password = password
    self.password_salt = User.generate_salt
    self.password_hash = User.hash_password(password, password_salt)
  end

  def self.authenticate(email, password)
    return nil unless email.present?

    user = User.find_by(email: email.downcase)
    return nil if user.nil?

    password_hash = hash_password(
      password,
      user.password_salt
    )

    if password_hash == user.password_hash
      user
    end
  end

  def self.hash_password(password, salt)
    BCrypt::Engine.hash_secret(password, salt)
  end

  def self.generate_salt
    BCrypt::Engine.generate_salt
  end

  private

  def password_required?
    !persisted? || password.present?
  end

  def downcase_email
    self.email = email.downcase
  end
end
