require 'rails_helper'

RSpec.describe TagsHelper, type: :helper do
  describe '#tag_links' do
    let(:page) { create(:page, tags_string: 'foo, bar') }
    let(:result) { helper.tag_links(page.tags.ordered) }

    it 'returns a list of tag links' do
      expected = <<~HTML.squish
        <a href="/tag/bar">bar (1)</a>
        <a href="/tag/foo">foo (1)</a>
      HTML
      expect(result).to eq(expected)
    end
  end
end
