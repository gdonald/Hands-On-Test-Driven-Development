require 'rails_helper'

RSpec.describe 'Home' do
  it 'renders homepage' do
    create(:page, :published)

    visit root_path

    within 'header' do
      expect(page).to have_link 'My Blog'
    end

    articles = find_all('article')
    expect(articles.size).to eq(1)

    within articles.first do
      expect(page).to have_css('h2', text: Page.last.title)
    end
  end
end
