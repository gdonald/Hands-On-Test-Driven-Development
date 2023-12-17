class Tag < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :page_tags, dependent: :destroy
  has_many :pages, through: :page_tags

  scope :ordered, -> { order(:name) }
end
