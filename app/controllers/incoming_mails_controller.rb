class IncomingMailsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :verify_signature
  
  SECRET = 'f811674dbd7be5b5e77f'
  
  def create
    message = Mail.new(params[:message])
    render :text => message.subject
  end
  
  protected
  
    def verify_signature
      provided = request.request_parameters.delete(:signature)
      signature = Digest::MD5.hexdigest(request.request_parameters.sort.map{|k,v| v}.join + SECRET)
      
      if provided != signature
        render :text => "Message signature fail #{provided} != #{signature}", :status => 403
        return false 
      end
    end
end