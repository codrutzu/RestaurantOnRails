require "rails_helper"

RSpec.describe UserMailer, type: :mailer do

  fixtures :users 

  describe "when testing account activation" do
    it "should match user informations" do
      user = users(:michael)
      user.activation_token = User.new_token
      mail = UserMailer.account_activation(user)
      expect(mail.subject).to eq("Account activation")
      expect(user.email).to eq(mail.to[0])
      expect(mail.from[0]).to eq("noreply@example.com")
      expect(mail.body.encoded).to match(user.name)
      expect(mail.body.encoded).to match(user.activation_token)
      expect(mail.body.encoded).to match(CGI.escape(user.email))
    end
  end

  describe "When testing password reset" do
    it "should match user informations" do
      user = users(:michael)
      user.reset_token = User.new_token
      mail = UserMailer.password_reset(user)
      expect(mail.subject).to eq("Password reset")
      expect(user.email).to eq(mail.to[0])
      expect(mail.from[0]).to eq("noreply@example.com")
      expect(mail.body.encoded).to match(user.reset_token)
      expect(mail.body.encoded).to match(CGI.escape(user.email))
    end
  end
end
