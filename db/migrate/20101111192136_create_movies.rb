class CreateMovies < ActiveRecord::Migration
  def self.up
    create_table :movies do |t|
      t.string    :title
      t.string    :description
      
      t.string    :poster_file_name
      t.string    :poster_content_type
      t.integer   :poster_file_size
      t.datetime  :poster_updated_at
      
      t.timestamps
    end
  end

  def self.down
    drop_table :movies
  end
end
