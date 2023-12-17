module PageSearch
  def self.search(params)
    return [] unless params.present?

    pages = if params[:year].present? && params[:month].present?
              Page.by_year_month(params[:year], params[:month])
            elsif params[:term].present?
              Page.by_term(params[:term])
            end

    return [] unless pages

    pages.published.ordered
  end
end
