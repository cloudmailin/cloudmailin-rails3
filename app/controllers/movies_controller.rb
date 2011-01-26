class MoviesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  respond_to :json, :only => :index
  
  def index
    render :json => Movie.all
  end
  
  def create
    # Read the message from the message params and create a new mail object to work with it
    MovieMailer.receive(Mail.new(params[:message]))
    render :text => "Done"
  end
end
