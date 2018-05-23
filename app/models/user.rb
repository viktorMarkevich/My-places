class User < ApplicationRecord
  has_secure_password
  has_secure_token :confirmation_token

  before_create :generate_confirmation_instructions

  private

    def generate_confirmation_instructions
      self.confirmation_token = SecureRandom.hex(10)
      self.confirmation_sent_at = Time.now.utc
    end
end
