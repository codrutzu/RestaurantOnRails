require 'rails_helper'

RSpec.describe User do
  before do
    @user = User.new(name: 'Example User', email: 'user@example.com', password: 'foobar', password_confirmation: 'foobar')
  end

  describe 'validation' do
    context 'when creating a valid new user' do
      it 'should be valid' do
        expect(@user.valid?).to be(true)
      end
      it 'should have a name' do
        @user.name = ''
        expect(@user.valid?).to be(false)
      end
      it 'shold have an email' do
        @user.email = ''
        expect(@user.valid?).to be(false)
      end
      it 'should not have a name of 51 characters or longer' do
        @user.name = 'a' * 51
        expect(@user.valid?).to be(false)
      end
      it 'should not have an email of 256 characters or longer' do
        @user.email = 'a' * 244 + '@example.org'
        expect(@user.valid?).to be(false)
      end
      it 'should accept only valid addresses' do
        valid_addressses = %w[user@example.com USER@foo.com A_US-ER@foo.bar.org first.last@foo.jp alice+boob@baz.cn]
        valid_addressses.each do |valid_address|
          @user.email = valid_address
          expect(@user.valid?).to be(true), "#{valid_address.inspect} is not correct"
        end
      end
      it 'should have an unique email' do
        duplicate_user = @user.dup
        @user.save
        expect(duplicate_user.valid?).to be(false)
      end
      it 'should have email saved as lower-case' do
        mixed_case_email = 'FoO@eXaMpLe.cOm'
        @user.email = mixed_case_email
        @user.save
        expect(mixed_case_email.downcase).to eq @user.reload.email
      end
      it 'should havea password(nonblank)' do
        @user.password = "  "
        expect(@user.valid?).to be(false)
      end
      it 'should have a minimum length password' do
        @user.password = @user.password_confirmation = 'a' * 5
        expect(@user.valid?).to be(false)
      end
    end
  end
end
