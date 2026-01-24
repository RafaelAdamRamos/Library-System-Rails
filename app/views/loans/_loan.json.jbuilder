json.extract! loan, :id, :borrowed_at, :expected_return_at, :returned_at, :fine_amount, :user_id, :book_copy_id, :created_at, :updated_at
json.url loan_url(loan, format: :json)
