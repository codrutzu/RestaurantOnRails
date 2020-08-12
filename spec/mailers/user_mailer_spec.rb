require "rails_helper"

RSpec.describe UserMailer, type: :mailer do

  # fixtures :users
  # describe "account_activation" do
  #   let(:mail) { UserMailer.account_activation }

  #   it "renders the headers" do
  #     expect(mail.subject).to eq("Account activation")
  #     expect(mail.to).to eq(["to@example.org"])
  #     expect(mail.from).to eq(["from@example.com"])
  #   end

  #   it "renders the body" do
  #     expect(mail.body.encoded).to match("Hi")
  #   end
  # end

  # describe "password_reset" do
  #   let(:mail) { UserMailer.password_reset }

  #   it "renders the headers" do
  #     expect(mail.subject).to eq("Password reset")
  #     expect(mail.to).to eq(["to@example.org"])
  #     expect(mail.from).to eq(["from@example.com"])
  #   end

  #   it "renders the body" do
  #     expect(mail.body.encoded).to match("Hi")
  #   end
  # end

  # describe "account_activation" do
  #   it "work" do
  #     user = users(:michael)
  #     user.activation_token = User.new_token
  #     mail = UserMailer.account_activation(user)
  #   end
  # end
end
