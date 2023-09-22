require 'rails_helper'

RSpec.describe Bill, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      bill = Bill.new(name: 'Test Bill', amount: 10.0, user: User.new(name: 'Test User'))
      expect(bill).to be_valid
    end

    it 'is not valid without a name' do
      bill = Bill.new(amount: 10.0, user: User.new(name: 'Test User'))
      expect(bill).not_to be_valid
    end

    it 'is not valid without an amount' do
      bill = Bill.new(name: 'Test Bill', user: User.new(name: 'Test User'))
      expect(bill).not_to be_valid
    end

    it 'is not valid with a negative amount' do
      bill = Bill.new(name: 'Test Bill', amount: -10.0, user: User.new(name: 'Test User'))
      expect(bill).not_to be_valid
    end

    it 'is not valid without a user' do
      bill = Bill.new(name: 'Test Bill', amount: 10.0)
      expect(bill).not_to be_valid
    end
  end
end
