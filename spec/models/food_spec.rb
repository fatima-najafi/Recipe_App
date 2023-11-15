require 'rails_helper'

RSpec.describe Food, type: :model do
  describe 'creation' do
    before :all do
      @user = User.create(name: 'Fatima', email: 'fatima@gmail.com')
      @food = Food.create(name: 'Food', measurement_unit: 'kg', price: 100, quantity: 200, user_id: @user.id)
    end

    it 'has a name' do
      expect(@food.name).to eq('Food')
    end

    it 'has measurement unite' do
      expect(@food.measurement_unit).to eq('kg')
    end

    it 'has price' do
      expect(@food.price).to eq(100)
    end

    it 'has quantity' do
      expect(@food.quantity).to eq(200)
    end

    it 'belongs to a user' do
      expect(@food.user_id).to eq(@user.id)
    end
  end
end
