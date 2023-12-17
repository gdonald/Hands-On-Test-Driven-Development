require 'rails_helper'

RSpec.describe 'pages/show', type: :view do
  let(:page) { build(:page) }

  it 'renders the page object' do
    assign(:page, page)
    render
    expect(rendered).to have_css('h2', text: page.title)
    expect(rendered).to have_css('p', text: page.created_at.to_fs)
    expect(rendered).to include(page.content)
  end
end
