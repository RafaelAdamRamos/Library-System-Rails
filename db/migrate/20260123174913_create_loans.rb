class CreateLoans < ActiveRecord::Migration[8.1]
  def change
    create_table :loans do |t|
      t.date :borrowed_at, null: false
      t.date :expected_return_at, null: false
      t.date :returned_at
      t.decimal :fine_amount, precision: 7, scale: 2
      t.references :user, null: false, foreign_key: true
      t.references :book_copy, null: false, foreign_key: true

      t.timestamps
    end
  end
end
