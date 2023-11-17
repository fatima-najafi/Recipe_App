class RecipeFood < ApplicationRecord
  validates :quantity, presence: true
  belongs_to :recipe
  belongs_to :food
end
