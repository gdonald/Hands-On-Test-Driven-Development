class HomeController < ApplicationController
  def index
    @pages = Page.published.ordered.page(params[:page])
  end

  def sitemap
    @url = ENV['BASE_URL'] || 'http://localhost:3000'
  end
end
