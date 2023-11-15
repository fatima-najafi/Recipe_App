require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  subject(:user) { User.new(name: 'Fatima', email: 'fatima@gmail.com') }

  let!(:recipe) do
    Recipe.create(name: 'Recipe', description: 'Recipe Test', public: true, preparation_time: 10,
                  cooking_time: 10, user_id: user.id)
  end

  let!(:food) do
    Food.create(name: 'Food', user_id: user.id, measurement_unit: 'KG', price: 10, quantity: 10)
  end

  let!(:recipe_food) do
    RecipeFood.create(recipe_id: recipe.id, food_id: food.id, quantity: 1)
  end

  before { recipe_food.save }

  describe 'Validations' do
    it 'is not valid without a food_id' do
      recipe_food.food_id = nil
      expect(recipe_food).to_not be_valid
    end
    it 'is not valid without a recipe_id' do
      recipe_food.recipe_id = nil
      expect(recipe_food).to_not be_valid
    end

    it 'is not valid with a recipe_id that does not exist' do
      recipe_food.recipe_id = 0
      expect(recipe_food).to_not be_valid
    end
    it 'is not valid with a recipe_id less than 0' do
      recipe_food.recipe_id = -1
      expect(recipe_food).to_not be_valid
    end

    it 'is not valid with a food_id less than 0' do
      recipe_food.food_id = -1
      expect(recipe_food).to_not be_valid
    end
  end

  describe 'View' do
    it 'should have a description' do
      expect(recipe.description).to eq('Recipe Test')
    end

    it 'should have a name' do
      expect(recipe.name).to eq('Recipe')
    end

    it 'should have a recipe_id' do
      expect(recipe_food.recipe_id).to eq(recipe.id)
    end
    it 'should have a public' do
      expect(recipe.public).to eq(true)
    end

    it 'should have quantity' do
      expect(recipe_food.quantity).to eq(1)
    end
  end
end
