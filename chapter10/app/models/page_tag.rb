class PageTag < ApplicationRecord
  belongs_to :page
  belongs_to :tag, counter_cache: true

  validates :tag_id, uniqueness: { scope: :page_id }
end
