FactoryBot.define do
  factory :page_tag do
    page { create(:page) }
    tag { create(:tag) }
  end
end
