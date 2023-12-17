require 'rails_helper'

RSpec.describe 'shared/_page.html.erb', type: :view do
  let(:page) { build(:page) }

  it 'renders the page object' do
    assign(:page, page)
    render partial: 'shared/page',
            locals: {
              page: page,
              content: '<p>content</p>'
            }
    expect(rendered).to have_css('h2', text: page.title)
    expect(rendered).to have_css('p', text: page.created_at.to_fs)
    expect(rendered).to have_css('p', text: 'content')
  end
end
