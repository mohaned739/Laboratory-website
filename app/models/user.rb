class User < ApplicationRecord
    has_secure_password
    validates :name, :email, :password_digest, :phone, :national_id, presence: true
    validates :email, confirmation: { case_sensitive: false }
    validates :email, :national_id, uniqueness: true
    validates :password_digest ,length: {minimum: 8}
    validates_length_of :national_id, minimum: 14, maximum: 14
    validates_length_of :phone, minimum: 10, maximum: 10
    has_many :reports, dependent: :destroy
end
