class MoviesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  def create
    # Read the message from the message params and create a new mail object to work with it
    MovieMailer.receiver(Mail.new(params[:message]))
    render :text => "Done"
  end
end
