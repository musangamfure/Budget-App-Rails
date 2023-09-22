require 'rails_helper'

RSpec.describe 'Categories page', type: :system do
  describe 'Categories /index' do
    before(:each) do
      @user = User.create(name: 'name', email: 'email@gmail.com', password: '123456')
      @icon_file = fixture_file_upload(Rails.root.join('spec', 'tests', 'files', 'test.png'), 'image/png')
      @category = Category.create(name: 'food', icon: @icon_file, user: @user)
      @user.save!
      visit new_user_session_path
      fill_in 'user_email', with: 'email@gmail.com'
      fill_in 'user_password', with: '123456'
      click_button 'Log in'
      sleep(1)
      visit categories_path
    end

    after(:each) do
      sleep(2)
    end

    it 'displays the name, date, and total amount of category' do
      expect(page).to have_content(@category.name)
      expect(page).to have_content(@category.bills.sum(:amount))
    end

    it 'clicks on category' do
      link = find('a', text: @category.name, match: :first)
      link.click
      sleep(1)
      expect(page).to have_current_path category_path(@category)
    end

    it 'clicks on add new category button' do
      link = find('a', text: 'Add new category')
      link.click
      sleep(1)
      expect(page).to have_current_path new_category_path
    end
  end

  describe 'Categories /show' do
    before(:each) do
      @user = User.create!(name: 'name', email: 'email@gmail.com', password: '123456')
      @icon_file = fixture_file_upload(Rails.root.join('spec', 'tests', 'files', 'test.png'), 'image/png')
      @category = Category.create(name: 'food', icon: @icon_file, user: @user)
      @bill = Bill.create(name: 'cake', amount: 100, category_ids: [@category.id], user: @user)
      @user.save!
      visit new_user_session_path
      fill_in 'user_email', with: 'email@gmail.com'
      fill_in 'user_password', with: '123456'
      click_button 'Log in'
      sleep(1)
      visit category_path(@category)
    end

    after(:each) do
      sleep(2)
    end

    it 'displays the name, date, and amount of bill' do
      expect(page).to have_content(@bill.name)
      expect(page).to have_content(@bill.created_at.strftime('%d-%m-%Y'))
      expect(page).to have_content(@bill.amount)
    end

    
  end
end
