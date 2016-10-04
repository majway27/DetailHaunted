json.array!(@journals) do |journal|
  json.extract! journal, :id, :summary, :entry, :user_id
  json.url journal_url(journal, format: :json)
end
