require 'rails_helper'

describe User, type: :model do
  describe 'validations' do
    before do
      @user = User.create(first_name: 'Pierre', last_name: 'Liard', email: 'pierre@example.com', password: 'foobar', password_confirmation: 'foobar')
    end

    it 'can be created' do
      expect(@user).to be_valid
    end

    it 'cannot be created without a first name' do
      @user.first_name = nil

      expect(@user).not_to be_valid
    end

    it 'cannot be created without a last name' do
      @user.last_name = nil

      expect(@user).not_to be_valid
    end

    it 'cannot be created without an email' do
      @user.email = nil

      expect(@user).not_to be_valid
    end

    it 'cannot have a too short first name' do
      @user.first_name = 'a'

      expect(@user).not_to be_valid
    end

    it 'cannot have a too long first name' do
      @user.first_name = 'a' * 35

      expect(@user).not_to be_valid
    end

    it 'cannot have an invalid email address' do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]

      invalid_addresses.each do |invalid_address|
        @user.email = invalid_address

        expect(@user).not_to be_valid
      end
    end

    it 'must have a unique email address' do
      @user = User.new(first_name: 'Jane', last_name: 'Doe', email: 'PIERRE@example.com')

      expect(@user).not_to be_valid
    end

    it 'must have a non blank password' do
      @user.password = @user.password_confirmation = ' ' * 6

      expect(@user).not_to be_valid
    end

    it 'must have a password with a minimum length' do
      @user.password = @user.password_confirmation = 'a' * 5

      expect(@user).not_to be_valid
    end
  end
end
