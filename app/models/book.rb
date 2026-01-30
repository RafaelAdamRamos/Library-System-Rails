class Book < ApplicationRecord
  has_many :book_copies
  has_one_attached :cover

   validates :cover,
            content_type: %i[png jpg jpeg webp],
            size: { less_than: 5.megabytes }
end
