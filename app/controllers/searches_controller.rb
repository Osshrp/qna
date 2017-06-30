class SearchesController < ApplicationController
  def show
    result = Search.execute(params[:search], params[:scope])
    byebug
  end
end
