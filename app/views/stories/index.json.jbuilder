json.array!(@stories) do |story|
  json.extract! story, :id, :title, :storyfile
  json.url story_url(story, format: :json)
end
