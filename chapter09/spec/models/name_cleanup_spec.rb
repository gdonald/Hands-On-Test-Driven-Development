require 'rails_helper'

RSpec.describe NameCleanup do
  let(:name) { '  - -Foo Bar! _ 87 --  ' }

  describe '.clean' do
    it 'cleans a name' do
      expect(NameCleanup.clean(name)).to eq('foo-bar-87')
    end
  end
end
