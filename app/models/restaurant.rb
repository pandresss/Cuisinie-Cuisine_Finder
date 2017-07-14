class Restaurant < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :comments
  has_many :restaurant_users , dependent: :destroy
end
