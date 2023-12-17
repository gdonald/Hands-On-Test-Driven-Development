class TagsController < ApplicationController
  def show
    tag = Tag.find_by(name: params[:name])
    redirect_to root_path and return unless tag
    
    @pages = tag.pages.published.ordered.page(params[:page])
  end
end
