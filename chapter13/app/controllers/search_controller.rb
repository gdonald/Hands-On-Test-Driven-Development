class SearchController < ApplicationController
  def index
    @pages = PageSearch.search(params)
  end
end
