require 'rails_helper'

RSpec.describe 'home/index', type: :view do
  let(:page) { build(:page) }

  it 'renders the page object' do
    assign(:pages, [page])
    render
    expect(rendered).to have_css('h2', text: page.title)
    expect(rendered).to have_css('p', text: page.created_at.to_fs)
    expect(rendered).to include(page.summary)
  end
end
