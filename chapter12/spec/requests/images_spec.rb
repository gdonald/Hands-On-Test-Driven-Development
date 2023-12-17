require 'rails_helper'

RSpec.describe 'Images' do
  it 'returns an image' do
    create(:image)
    get image_path(Image.last)

    expect(response).to be_successful
    expect(response.content_type).to eq('image/jpeg')
  end

  it 'returns a missing image if the image does not exist' do
    get image_path(0)
  
    expect(response).to be_successful
    expect(response.content_type).to eq('image/jpeg')
  end
end
