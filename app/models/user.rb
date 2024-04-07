class User < ApplicationRecord
  EMAIL_REGEX = /\A\w+([.-]?\w+)*@\w+([.-]?\w+)*(\.\w{2,3})+\z/

  has_secure_password

  before_save :downcase_email

  validates :name, presence: true, length: { minimum: 2, maximum: 150 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 320 },
                    format: { with: EMAIL_REGEX, message: I18n.t("users.model.email_validation") }

  validates :password, length: { minimum: 8 }, on: :create

  private

  def downcase_email
    email.downcase!
  end
end
