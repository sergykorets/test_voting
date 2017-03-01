json.extract! poll, :id, :title, :yes_votes, :no_votes, :undefined_votes, :created_at, :updated_at
json.url poll_url(poll, format: :json)