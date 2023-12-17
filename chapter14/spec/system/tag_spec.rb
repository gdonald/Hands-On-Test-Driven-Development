require 'rails_helper'

RSpec.describe 'Tag', type: :system do
  let(:page_1) { create(:page, :published, tags_string: 'foo, bar') }
  let(:page_2) { create(:page, :published, tags_string: 'bar') }

  before do
    [page_1, page_2]
  end

  it 'displays clickable tags on a page' do
    visit root_path

    find_link(href: '/tag/foo').click
    expect(page).to have_content(page_1.title)
    expect(page).to_not have_content(page_2.title)

    find_link(href: '/tag/bar', match: :first).click
    expect(page).to have_content(page_1.title)
    expect(page).to have_content(page_2.title)
  end

  context 'when a tag does not exist' do
    it 'redirects to the root path' do
      visit '/tag/does-not-exist'
      expect(page).to have_current_path(root_path)
    end    
  end

  describe 'pagination' do
    context 'with many tagged pages' do
      it 'paginates' do
        tag = create(:tag)
        create_list(:page, 3, :published)
        Page.all.each { |page| page.tags << tag }

        visit tag_path(name: tag.name)

        articles = find_all('article')
        expect(articles.size).to eq(2)
        expect(page).to have_link('Next')
      end
    end
  end
end
