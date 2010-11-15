class IncomingMailsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :verify_signature
  
  SECRET = ENV['CLOUDMAILIN_SECRET'] || 'a67b82d1d02974b87c3d'
  
  def create
    message = Mail.new(params[:message])
    render :text => message.subject
  end
  
  protected
  
    def verify_signature
      provided = request.request_parameters.delete(:signature)
      joined = request.request_parameters.sort.map{|k,v| v }.join + SECRET
      Rails.logger.info joined
      
      signature = Digest::MD5.hexdigest(joined)
      
      if provided != signature
        error = "Message signature fail #{provided} != #{signature}"
        Rails.logger.warn error
        render :text => error, :status => 403, :content_type => Mime::TEXT.to_s
        return false 
      end
    end
end