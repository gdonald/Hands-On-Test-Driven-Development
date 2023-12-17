require 'rails_helper'

RSpec.describe 'Pages' do
  let(:my_page) { create(:page, :published) }

  it 'renders page' do
    visit page_path(slug: my_page.slug)

    article = find('article')

    within article do
      expect(page).to have_css('h2', text: my_page.title)
    end
  end

  describe 'syntax highlighting' do
    before do
      content = <<~RUBY.squish
        <pre>
          <code class="language-ruby">
            puts 'hello world!'
          </code>
        </pre>
      RUBY

      my_page.update(content:)
    end

    it 'renders code blocks' do
      visit page_path(slug: my_page.slug)

      within 'pre' do
        expect(page).to have_text('puts')

        within 'code.language-ruby span.token.string' do
          expect(page).to have_text('hello world!')
        end  
      end
    end
  end
end
