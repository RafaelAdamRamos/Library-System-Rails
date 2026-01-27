json.extract! user, :id, :name, :cpf, :email_address, :user_type, :password, :created_at, :updated_at
json.url user_url(user, format: :json)
