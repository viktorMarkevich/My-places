class User < ApplicationRecord
  has_secure_password
  has_secure_token :confirmation_token

  before_create :generate_confirmation_instructions
  after_create :generate_confirmation_email

  def full_name
    "#{first_name} #{last_name}"
  end

  def set_confirmation
    generate_confirmation_email
  end

  private

    def generate_confirmation_instructions
      self.confirmation_token = SecureRandom.hex(10)
      self.confirmation_sent_at = Time.now.utc
    end

    def generate_confirmation_email
      ConfirmationMailer.send_confirmation_email(self, full_name, email).deliver_now
    end
end
