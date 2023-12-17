require 'rails_helper'

RSpec.describe 'shared/_side_bar', type: :view do
  it 'renders the side_bar' do
    allow(view).to receive(:render).and_call_original
    render
    expect(view).to have_received(:render).with('shared/search_form')
    expect(view).to have_received(:render).with('shared/archives')
  end
end
