require 'rails_helper'

RSpec.describe 'Home Page', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get root_path
      expect(response).to be_successful
    end
  end
end
