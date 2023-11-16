require 'rails_helper'

RSpec.describe 'Food', type: :feature do
  before(:each) do
    @user = User.create(name: 'John', email: 'john@gmail.com', password: '1234567890',
                        password_confirmation: '1234567890')
    @recipe = Recipe.create(name: 'Vanilla', preparation_time: 2, cooking_time: 3, description: 'The best ever',
                            public: true, user_id: @user.id)
    @food = Food.create(name: 'Apple', measurement_unit: 'units', price: 10, quantity: 15, user_id: @user.id)
    @recipe_food = RecipeFood.create(quantity: 20, food_id: @food.id, recipe_id: @recipe.id)

    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
  end

  describe 'Recipe food page' do
    it 'render add ingredient form' do
      visit new_recipe_recipe_food_path(@recipe)
      expect(page).to have_content('Food name')
      expect(page).to have_content('Ingredient quantity')
      expect(page).to have_button('Add Ingredient')
    end

    it 'show remove button in recipe show page' do
      visit recipe_path(@recipe)
      expect(page).to have_content(@recipe.name)
    end

    it 'show recipe food details' do
      visit recipe_recipe_foods_path(@recipe)
      expect(page).to have_content(@recipe.foods.name)
    end
  end
end
