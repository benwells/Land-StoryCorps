class AddUserIdToStory < ActiveRecord::Migration
  def change
    add_column :stories, :user_id, :integer, references: :users
    add_index :stories, :user_id
  end
end
