require 'rails_helper'

RSpec.describe Category, type: :model do
  subject do
    @user = User.create(name: 'emma', email: 'emma@gmail.com', password: '123456')
    @icon_file = fixture_file_upload(Rails.root.join('spec', 'tests', 'files', 'test.png'), 'image/png')
    @category = Category.create(name: 'food', icon: @icon_file, user: @user)
  end

  before { subject.save }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'name should have a valid value' do
    expect(subject.name).to eql 'food'
  end

  it 'user should be present' do
    subject.user = nil
    expect(subject).to_not be_valid
  end

  it 'can have an attached icon' do
    expect(subject).to respond_to(:icon)
  end
end
