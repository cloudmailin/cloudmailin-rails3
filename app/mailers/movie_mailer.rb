class MovieMailer < ActionMailer::Base
  # Create an attachment file with some paperclip aware features
  class AttachmentFile < Tempfile
    attr_accessor :original_filename, :content_type
  end
  
  # Called whenever a message is received on the movies controller
  def receive(message)
    # For now just take the first attachment and assume there is only one
    attachment = message.attachments.first
    
    # Create the movie itself
    Movie.create do |movie|
      movie.title = message.subject
      
      # Create an AttachmentFile subclass of a tempfile with paperclip aware features and add it
      poster_file = AttachmentFile.new('test.jpg')
      poster_file.write attachment.decoded
      poster_file.flush
      poster_file.original_filename = attachment.filename
      poster_file.content_type = attachment.mime_type
      movie.poster = poster_file
    end
  end
end
