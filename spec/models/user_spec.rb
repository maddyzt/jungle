require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do 
    context 'Passwords' do
      it "should not save if password is blank" do
        @user = User.new(first_name: "Maddy", email: "Maddy@email.com", password: "", password_confirmation: "password")
        @user.save
        expect(@user.id).not_to be_present
      end

      it "should not save if password_confirmation is blank" do
        @user = User.new(first_name: "Maddy", email: "Maddy@email.com", password: "password", password_confirmation: "")
        @user.save
        expect(@user.id).not_to be_present
      end

      it "should not save if the password and password_confirmation fields do not match" do 
        @user = User.new(first_name: "Maddy", email: "Maddy@email.com", password: "password", password_confirmation: "password1")
        @user.save
        expect(@user.errors.full_messages).to include ("Password confirmation doesn't match Password")
      end

      it "should not save if password is less than 3 characters long" do 
        @user = User.new(first_name: "Maddy", email: "Maddy@email.com", password: "12", password_confirmation: "12")
        @user.save
        expect(@user.id).not_to be_present
      end
    end

    context 'Name & Email' do 
      it "should not save if the email already exists in the database" do 
        @user1 = User.new(first_name: "Maddy", email: "Maddy@email.com", password: "password", password_confirmation: "password")
        @user2 = User.new(first_name: "Maddy", email: "Maddy@email.com", password: "password", password_confirmation: "password")
        @user1.save
        @user2.save
        expect(@user2.id).not_to be_present
      end

      it "should not save if the email is not present" do 
        @user = User.new(first_name: "Maddy", email: "", password: "password", password_confirmation: "password")
        @user.save
        expect(@user.id).not_to be_present
      end
    end
  end

  describe '.authenticate_with_credentials' do 
    it "should return a valid user given valid email and password" do
      @email = 'Maddy@email.com'
      @password = 'password'
      @user = User.create(first_name: "Maddy", email: @email, password: @password, password_confirmation: "password")
      user = User.authenticate_with_credentials(@email, @password)
      expect(user).to be_present
    end

    it "should return a valid user when blank space is added before/after a valid email" do
      @email = '   Maddy@email.com'
      @password = 'password'
      @user = User.create(first_name: "Maddy", email: 'Maddy@email.com', password: @password, password_confirmation: "password")
      user = User.authenticate_with_credentials(@email, @password)
      expect(user).to be_present
    end

    it "should return a valid user when user types in the wrong case for a valid email" do
      @email = 'Maddy@email.com'
      @password = 'password'
      @user = User.create(first_name: "Maddy", email: 'Maddy@email.com', password: @password, password_confirmation: "password")
      user = User.authenticate_with_credentials(@email, @password)
      expect(user).to be_present
    end

    it "should return nil when the email is not found" do
      @email = 'Maddy@email.com'
      @password = 'password'
      @user = User.create(first_name: "Maddy", email: @email, password: @password, password_confirmation: "password")
      user = User.authenticate_with_credentials('test@email.com', @password)
      expect(user).to be_nil
    end

    it "should return nil when the password is incorrect" do
      @email = 'Maddy@email.com'
      @password = 'password'
      @user = User.create(first_name: "Maddy", email: @email, password: @password, password_confirmation: "password")
      user = User.authenticate_with_credentials(@email, 'password1')
      expect(user).to be_nil
    end
  end
end
