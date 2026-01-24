json.extract! user, :id, :name, :cpf, :email, :user_type, :password_digest, :created_at, :updated_at
json.url user_url(user, format: :json)
