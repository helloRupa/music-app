require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password_digest) }
    it do
      should validate_length_of(:password).
      is_at_least(8)
    end
  end

  describe 'instance methods' do
    subject(:user) { User.new(email: 'a@a.com', password: '12345678') }

    context '#is_password?' do
      it 'returns true only when the provided password matches' do
        expect(user.is_password?('password')).to be(false)
        expect(user.is_password?('12345678')).to be(true)
      end
    end

    context '#reset_session_token!' do
      it 'generates a new session token' do
        token = user.session_token
        user.reset_session_token!

        expect(user.session_token).not_to eq(token)
      end
    end
  end

  describe 'class methods' do
    email = 'blarb@blarb.com'
    password = '12345678'
    User.create(email: email, password: password)
    id = User.last.id

    context '::find_by_credentials' do
      it 'returns nil when no matching user is found' do
        expect(User.find_by_credentials('fam', '123')).to be(nil)
        expect(User.find_by_credentials(email, '123')).to be(nil)
        expect(User.find_by_credentials('fam', password)).to be(nil)
      end

      it 'returns an object of type User when a match is found' do
        expect(User.find_by_credentials(email, password)).to be_instance_of(User)
      end

      it 'returns the correct user' do
        user = User.find_by_credentials(email, password)
        expect(user.id).to eq(id)
      end
    end
  end
end
