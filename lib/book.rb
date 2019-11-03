class Book < ActiveRecord::Base
    has_many :user_books
    has_many :user, through: :user_books
end