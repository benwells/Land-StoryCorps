class AddStorynameToStories < ActiveRecord::Migration
  def change
    add_column :stories, :storyname, :string
  end
end
