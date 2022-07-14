json.extract! bug, :id, :title, :description, :screenshot, :deadline, :bug_type, :status, :created_at, :updated_at
json.url bug_url(bug, format: :json)
