class RecipesController < ApplicationController
  def index
    @recipes = current_user.recipes
  end

  def show
    @recipe = Recipe.includes(:foods).find(params[:id])
    @foods = @recipe.foods
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)

    if @recipe.save
      redirect_to recipes_path, notice: 'Recipe was created successfully'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @recipe = current_user.recipes.find(params[:id])

    if @recipe.destroy
      redirect_to recipes_path, notice: 'Recipe deleted successfully'
    else
      redirect_to recipes_path, notice: 'Recipe cannot delete'
    end
  end

  def toggle_public
    @recipe = Recipe.find(params[:id])
    @recipe.change_public_status
    redirect_to @recipe, notice: 'Recipe status has changed.'
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :public, :description)
  end
end
