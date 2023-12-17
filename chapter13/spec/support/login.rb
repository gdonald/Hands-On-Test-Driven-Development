def login_as(user)
  visit admin_root_path

  expect(page).to have_css('h2', text: 'Admin')
  expect(page).to have_css('h2', text: 'Sign in')

  fill_in 'Email', with: user.email
  fill_in 'Password', with: 'changeme'
  click_button 'Submit'

  expect(page).to have_css('h2', text: 'Dashboard')
end
