require 'rails_helper'

describe User do
  let(:user) { FactoryGirl.create :user }

  #it { expect(user).to validate_presence_of(:email) }
  it 'is invalid without an email' do
    #expect(user).to validate_presence_of(:email)
    expect(FactoryGirl.build :user, email: nil).not_to be_valid
  end

  #it { expect(user).to validate_presence_of(:first_name) }
  it 'is invalid without a name' do
    #expect(user).to validate_presence_of(:first_name)
    expect(FactoryGirl.build :user, first_name: nil).not_to be_valid
  end

  #it { expect(user).to validate_uniqueness_of(:email) }
  it 'has unique email' do
    #expect(user).to validate_uniqueness_of(:email)
    expect(FactoryGirl.build :user, email: user.email).not_to be_valid
  end

  #it { expect(user).to have_many(:posts) }
  it 'has many posts' do
    #expect(user).to have_many(:posts)
    expect(user).to respond_to :posts
  end

  context '.admins' do
    before do
      @users = FactoryGirl.create_list(:user, 3)
      @admins = FactoryGirl.create_list(:admin, 3)
    end

    it 'returns list of admins' do
      expect(User.admins).to match_array(@admins)
    end

    it "doesn't return regular users" do
      expect(User.admins).not_to match_array(@users)
    end
  end

  context 'change email' do
    it 'sends email changed notification' do
      user.email = Faker::Internet.email
      expect(UserMailer).to receive(:email_changed).with(user).and_return(double('mail', deliver: true))
      user.save
    end
    it "doesn't send email changed notification" do
      user.first_name = 'Santa Claus'
      expect(UserMailer).not_to receive(:email_changed)
      user.save
    end
  end
end