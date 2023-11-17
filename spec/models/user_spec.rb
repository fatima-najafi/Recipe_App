require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'should validate presence of name' do
      user = User.new(name: '')
      expect(user.valid?).to be false
      expect(user.errors[:name]).to include("can't be blank")
    end
  end
  describe 'associations' do
    it 'should have many foods and recipes' do
      user = User.reflect_on_association(:foods)
      expect(user.macro).to eq(:has_many)
      user = User.reflect_on_association(:recipes)
      expect(user.macro).to eq(:has_many)
    end
  end
end
