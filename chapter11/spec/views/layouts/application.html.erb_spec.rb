require 'rails_helper'

RSpec.describe 'layouts/application', type: :view do
  it 'renders the layout' do
    allow(view).to receive(:render).and_call_original
    render
    expect(view).to have_received(:render).with('shared/header')
    expect(view).to have_received(:render).with('shared/side_bar')
    expect(view).to have_received(:render).with('shared/footer')
  end
end
