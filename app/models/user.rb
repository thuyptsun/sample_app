class User < ApplicationRecord
  USER_PARAMS = %i(name email password password_confirmation).freeze
  VALID_EMAIL_REGEX = Settings.user.email_regex

  attr_accessor :remember_token

  validates :name, presence: true,
    length: {minimum: Settings.user.name_minlength,
             maximum: Settings.user.name_maxlength}

  validates :email, presence: true,
    length: {minimum: Settings.user.email_minlength,
             maximum: Settings.user.email_maxlength},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: true

  validates :password, presence: true,
    length: {minimum: Settings.user.password_minlength,
             maximum: Settings.user.password_maxlength},
    allow_nil: true

  has_secure_password

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end

    def remember
      self.remember_token = User.new_token
      update :remember_digest, User.digest(remember_token)
    end

    def authenticated? remember_token
      return false if remember_digest.nil?

      BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end
  end

  def forget
    update remember_digest: nil
  end

  private

  def downcase_email
    email.downcase!
  end
end
