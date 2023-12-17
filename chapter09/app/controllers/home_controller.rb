class HomeController < ApplicationController
  def index
    @pages = Page.published.ordered
  end
end
