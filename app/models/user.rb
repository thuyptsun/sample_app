class User < ApplicationRecord
  USER_PARAMS = %i(name email password password_confirmation).freeze
  VALID_EMAIL_REGEX = Settings.validations.user.email_regex

  validates :name, presence: true,
    length: {minimum: Settings.validations.user.name_minlength,
             maximum: Settings.validations.user.name_maxlength}

  validates :email, presence: true,
    length: {minimum: Settings.validations.user.email_minlength,
             maximum: Settings.validations.user.email_maxlength},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: true

  validates :password, presence: true,
    length: {minimum: Settings.validations.user.password_minlength,
             maximum: Settings.validations.user.password_maxlength}

  before_save :downcase_email

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
  end

  private

  def downcase_email
    email.downcase!
  end
end
