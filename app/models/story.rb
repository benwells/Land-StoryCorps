class Story < ActiveRecord::Base
  belongs_to :users, :foreign_key => "user_id"
  mount_uploader :storyfile, StoryFileUploader
end
