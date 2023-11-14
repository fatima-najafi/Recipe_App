class FoodsController < ApplicationController
  def index
    @foods = current_user.foods
  end

  def new
    @food = Food.new
  end

  def create
    @food = current_user.foods.new(food_params)
    if @food.save
      redirect_to foods_url, notice: 'Food item was successfully created.'
    else
      flash.now[:alert] = 'Food item could not be created.'
      render :new
    end
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy
    redirect_to foods_url, notice: 'Food item was successfully deleted.'
  end

  private

  # Define permitted parameters for creating a new food item
  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
