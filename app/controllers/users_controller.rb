class UsersController < ApplicationController
  def general_shopping_list
    @all_recipes = Recipe.all
    @recipes = current_user.recipes.includes(:foods)
    @general_foods = current_user.foods

    @missing_foods = calculate_missing_foods
    @total_count = @missing_foods.length
    @total_price = total_price(@missing_foods)
  end

  private

  def calculate_missing_foods
    missing_foods = []

    @all_recipes.each do |recipe|
      recipe.foods.each do |food|
        general_food = @general_foods.find_by(name: food.name)

        next unless general_food.nil? || general_food.quantity < food.quantity

        missing_foods << { name: food.name,
                           quantity: food.quantity - (general_food&.quantity || 0),
                           price: food.price }
      end
    end

    missing_foods
  end

  def total_price(foods)
    foods.sum { |food| food[:price] * food[:quantity] }
  end
end
