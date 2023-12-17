require 'rails_helper'

RSpec.describe 'Home Page', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get root_path
      expect(response).to be_successful
    end
  end

  describe 'GET /sitemap' do
    let(:doc) { Nokogiri::XML(response.body) }
    let(:urls) { doc.css('loc').collect(&:text) }
    let(:paths) { urls.map{ |url| URI.parse(url).path } }
    let(:tag) { create(:tag) }
    let!(:page) do
      create(
        :page,
        :published,
        tags: [tag],
        created_at: '2023-02-19'
      )
    end

    it 'returns http success' do
      get sitemap_path(format: :xml)
      expect(response).to be_successful

      expect(paths).to include(page_path(slug: page.slug))
      expect(paths).to include(tag_path(name: tag.name))
      expect(paths).to include('/search/2023/02')
    end
  end
end
