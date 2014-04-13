class AddLongituteToStory < ActiveRecord::Migration
  def change
    add_column :stories, :longitude, :string
    add_column :stories, :latitude, :string
  end
end
