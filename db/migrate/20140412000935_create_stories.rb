class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :title
      t.string :storyfile

      t.timestamps
    end
  end
end
