require 'rails_helper'

RSpec.describe 'Pages' do
  let(:my_page) { create(:page, :published) }

  it 'renders page' do
    visit page_path(slug: my_page.slug)

    article = find('article')

    within article do
      expect(page).to have_css('h2', text: my_page.title)
    end
  end
end
