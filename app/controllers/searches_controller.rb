class SearchesController < ApplicationController

  authorize_resource

  def show
    @region = params[:scope]
    @search_string = params[:search]
    @result = Search.execute(@search_string, @region)
    render 'show'
  end
end
