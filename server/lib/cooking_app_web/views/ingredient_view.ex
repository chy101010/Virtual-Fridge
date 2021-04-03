defmodule CookingAppWeb.IngredientView do
  use CookingAppWeb, :view
  alias CookingAppWeb.IngredientView

  def render("index.json", %{ingredients: ingredients}) do
    %{data: render_many(ingredients, IngredientView, "ingredient.json")}
  end

  def render("show.json", %{ingredient: ingredient}) do
    %{data: render_one(ingredient, IngredientView, "ingredient.json")}
  end

  def render("ingredient.json", %{ingredient: ingredient}) do
    %{id: ingredient.id,
      ingredient_name: ingredient.ingredient_name}
  end
end
