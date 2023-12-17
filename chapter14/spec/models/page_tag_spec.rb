require 'rails_helper'

RSpec.describe PageTag, type: :model do
  subject { create(:page_tag) }

  it { is_expected.to belong_to(:page) }
  it { is_expected.to belong_to(:tag).counter_cache }

  it { is_expected
    .to validate_uniqueness_of(:tag_id)
    .scoped_to(:page_id) }
end
