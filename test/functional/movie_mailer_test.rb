require 'test_helper'

class MovieMailerTest < ActionMailer::TestCase
  should "Add the first image extracted from the message" do
    message = Mail.new do
      from "test@example.com"
      to "test@example.com"
      subject "New Movie"
      add_file :filename => 'movie.jpg', :content => File.read('test/poster.jpg')
    end
    
    assert_difference("Movie.count", 1) do
      mailer = MovieMailer.receive(message)
      assert mailer.persisted?, mailer.errors.full_messages
      assert_equal "image/jpeg", mailer.poster_content_type
      assert_equal "movie.jpg", mailer.poster_file_name
      assert_equal File.read('test/poster.jpg'), File.read(mailer.poster.path(:original))
      assert_not_nil mailer.poster.path(:small)
    end
  end
end
