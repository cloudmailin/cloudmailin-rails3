class IncomingMailsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  def create
    message = Mail.new(params[:message])
    render :text => message.subject
  end
end