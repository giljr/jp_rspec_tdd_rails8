class Category < ApplicationRecord
    has_many :products

    validates :description, presence: true, uniqueness: { case_sensitive: false }
end
