class Page < ApplicationRecord
  belongs_to :user

  validates :title,
            presence: true,
            uniqueness: true

  validates :content,
            presence: true
  
  before_validation :make_slug

  scope :published, -> { where(published: true) }
  scope :ordered, -> { order(created_at: :desc) }

  scope :by_term, ->(term) do
    term.gsub!(/[^-\w ]/, '')
    terms = term.include?(' ') ? term.split : [term]
    pages = Page
    terms.each do |t|
      pages = pages.where('content ILIKE ?', "%#{t}%")
    end
    pages
  end

  scope :by_year_month, ->(year, month) do
    sql = <<~SQL
      extract(year from created_at) = ?
      AND
      extract(month from created_at) = ?
    SQL
    where(sql, year, month)
  end

  def self.month_year_list
    sql = <<~SQL
      SELECT DISTINCT
        TRIM(TO_CHAR(created_at, 'Month')) AS month_name,
        TO_CHAR(created_at, 'MM') AS month_number,
        TO_CHAR(created_at, 'YYYY') AS year
      FROM pages
      WHERE published = true
      ORDER BY year DESC, month_number DESC
    SQL
    ActiveRecord::Base.connection.execute(sql)
  end

  private

  def make_slug
    return unless title

    self.slug = title
                  .downcase   
                  .gsub(/[_ ]/, '-')
                  .gsub(/[^-a-z0-9+]/, '')
                  .gsub(/-{2,}/, '-')
                  .gsub(/^-/, '')
                  .chomp('-')
  end
end
