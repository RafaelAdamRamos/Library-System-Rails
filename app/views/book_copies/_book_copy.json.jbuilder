json.extract! book_copy, :id, :heritage_code, :status, :book_id, :created_at, :updated_at
json.url book_copy_url(book_copy, format: :json)
