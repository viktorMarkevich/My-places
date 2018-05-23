class User < ApplicationRecord
  has_secure_password
  has_secure_token :confirmation_token

  before_create :generate_confirmation_instructions
  after_create :generate_confirmation_email

  validates :email, :first_name, :last_name, :password, :password_confirmation, presence: true, on: :create

  def full_name
    "#{first_name} #{last_name}"
  end

  def set_confirmation
    generate_confirmation_email
  end

  def confirmation_token_valid?
    (self.confirmation_sent_at + 2.days) > Time.now.utc
  end

  def mark_as_confirmed!
    self.confirmation_token = nil
    self.confirmed_at = Time.now.utc
    save
  end

  private

    def generate_confirmation_instructions
      self.confirmation_token = generate_token
      self.confirmation_sent_at = Time.now.utc
    end

    def generate_token
      loop do
        token = SecureRandom.hex(10)
        break token unless User.where(confirmation_token: token).exists?
      end
    end

    def generate_confirmation_email
      ConfirmationMailer.send_confirmation_email(self, full_name, email).deliver_now
    end
end
