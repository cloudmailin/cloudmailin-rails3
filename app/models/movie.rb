class Movie < ActiveRecord::Base
  has_attached_file :poster, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  
  validates_presence_of :title
end
