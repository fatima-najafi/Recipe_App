require 'rails_helper'

RSpec.describe 'Recipe', type: :feature do
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

  describe 'Test for recipe' do
    it 'create a new recipe' do
      visit new_recipe_path
      fill_in 'Name', with: @recipe.name
      fill_in 'Preparation time', with: @recipe.preparation_time
      fill_in 'Cooking time', with: @recipe.cooking_time
      fill_in 'Description', with: @recipe.description
      click_button 'Create Recipe'
      expect(page).to have_content(@recipe.name)
    end

    it 'page should contain remove button' do
      visit recipes_path
      expect(page).to have_content('Remove')
    end

    it 'redirect to recipe show page' do
      visit recipes_path
      click_link 'Apple'
      expect(current_path).to match(recipe_path(@recipe.id))
    end

    it 'show recipe details' do
      visit recipe_path(@recipe.id)
      expect(page).to have_content(@recipe.name)
    end

    it 'contain button to add ingredient' do
      visit recipe_path(@recipe.id)
      expect(page).to have_content('Add Ingredient')
    end

    it 'contain button to generate shop list' do
      visit recipe_path(@recipe.id)
      expect(page).to have_content('Generate Shopping List')
    end
  end
end
