class CreateBookCopies < ActiveRecord::Migration[8.1]
  def change
    create_table :book_copies do |t|
      t.string :heritage_code, null: false
      t.string :title, :status, null: false
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end

    add_index :book_copies, :heritage_code, unique: true
  end
end
