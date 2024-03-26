json.extract! user, :id, :email, :is_admin, :created_at, :updated_at
json.url user_url(user, format: :json)
json.token user.generate_jwt