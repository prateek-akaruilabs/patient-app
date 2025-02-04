class Patient < ApplicationRecord
    validates :name, presence: true
    validates :dob, presence: true
    validates :email, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'Invalid email' }
end
