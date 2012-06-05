class QueryController < ApplicationController
  def index
    @auth = session[:auth]
  end
end
