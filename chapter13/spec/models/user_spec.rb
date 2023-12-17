require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  describe 'validations' do
    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to_not allow_value('foo@').for(:email) }
    it { is_expected.to_not allow_value('@bar.com').for(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_confirmation_of(:password) }
  end

  describe 'set a password' do
    let(:user) { build(:user) }

    it 'sets a password' do
      user.password = 'changeme'
      user.save!

      expect(user.password_salt).to be_present
      expect(user.password_hash).to be_present
    end
  end

  describe '.authenticate' do
    let(:user) { build(:user) }
    let(:password) { 'changeme' }

    before do
      user.password = password
      user.save!
    end

    it 'can authenticate' do
      expect(User.authenticate(user.email, password)).to eq(user)
    end

    it 'unknown email fails authenticate' do
      expect(User.authenticate('foo@bar.com', password)).to be_nil
    end

    it 'mixed case email can authenticate' do
      expect(User.authenticate(user.email.titleize, password)).to eq(user)
    end

    it 'nil email fails authentication' do
      expect(User.authenticate(nil, password)).to be_nil
    end
  end

  describe 'email' do
    context 'on create' do
      let(:user) { create(:user, email: 'Foo@baR.Com') }

      it 'is downcased' do
        expect(user.email).to eq('foo@bar.com')
      end
    end

    context 'on update' do
      let(:user) { create(:user, email: 'foo@bar.com') }

      before do
        user.update(email: 'Foo@baR.Com')
      end

      it 'is downcased' do
        expect(user.email).to eq('foo@bar.com')
      end
    end
  end

  describe 'password' do
    before { subject.save! }
    
    it 'is not required when updating name' do
      user = User.last
      expect(user.password).to be_nil

      user.update(name: 'New Name')
      expect(user).to be_valid
    end
  end
end
