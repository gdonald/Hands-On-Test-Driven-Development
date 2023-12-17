require 'rails_helper'

RSpec.describe 'Users' do
  let(:user) { create(:user) }

  before do
    login_as(user)
  end

  describe 'A new user' do
    it 'can be added' do
      visit new_admin_user_path

      fill_in 'Name', with: 'Foo Bar'
      fill_in 'Email', with: 'foo@bar.com'
      fill_in 'user[password]', with: 'changeme'
      fill_in 'user[password_confirmation]', with: 'changeme'

      click_button 'Create User'

      within '.flashes' do
        text = 'User was successfully created.'
        expect(page).to have_css('.flash_notice', text:)
      end

      within '#main_content' do
        expect(page).to have_css('td', text: 'Foo Bar')
        expect(page).to have_css('td', text: 'foo@bar.com')
      end
    end
  end

  describe 'An existing user' do
    it 'can be updated' do
      visit admin_users_path

      click_link 'Edit'

      expect(page).to have_field('user_name', with: user.name)
      expect(page).to have_field('user_email', with: user.email)
      
      fill_in 'Name', with: 'Bar Baz'
      fill_in 'Email', with: 'bar@baz.com'
      fill_in 'user[password]', with: 'change_me'
      fill_in 'user[password_confirmation]', with: 'change_me'

      click_button('Update User')

      within '.flashes' do
        text = 'User was successfully updated.'
        expect(page).to have_css('.flash_notice', text:)
      end

      within '#main_content' do
        expect(page).to have_css('td', text: 'Bar Baz')
        expect(page).to have_css('td', text: 'bar@baz.com')
      end
    end

    it 'can be deleted' do
      visit admin_users_path

      accept_confirm do
        click_link 'Delete'
      end

      within '.flashes' do
        expect(page).to have_css('.flash_notice',
          text: 'User was successfully destroyed.')
      end
    end
  end
end
