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

  describe 'Test for food page' do
    it 'create new food' do
      visit new_food_path
      fill_in 'Name', with: 'Banana'
      fill_in 'Measurement unit', with: 'grams'
      fill_in 'Price', with: 10
      fill_in 'Quantity', with: 15
      click_button 'Create Food'
      expect(page).to have_content('Banana')
    end

    it 'have food contents' do
      visit foods_path
      expect(page).to have_content(@food.name)
      expect(page).to have_content(@food.measurement_unit)
      expect(page).to have_content(@food.price)
      expect(page).to have_content(@food.quantity)
      expect(page).to have_content('Delete')
    end

    it 'have a delete button' do
      visit foods_path
      expect(page).to have_content('Delete')
    end
  end
end
