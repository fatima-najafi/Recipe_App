class Recipe < ApplicationRecord
  validates :name, presence: true
  validates :preparation_time, presence: true
  validates :cooking_time, presence: true
  validates :description, presence: true
  belongs_to :user
  has_many :recipe_foods
end
