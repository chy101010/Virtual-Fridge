defmodule CookingAppWeb.OwnedIngredientView do
  use CookingAppWeb, :view
  alias CookingAppWeb.OwnedIngredientView

  def render("index.json", %{ownedingredients: ownedingredients}) do
    %{data: render_many(ownedingredients, OwnedIngredientView, "owned_ingredient.json")}
  end

  def render("show.json", %{owned_ingredient: owned_ingredient}) do
    %{data: render_one(owned_ingredient, OwnedIngredientView, "owned_ingredient_single.json")}
  end

  def render("owned_ingredient_single.json", %{owned_ingredient: owned_ingredient}) do
    %{id: owned_ingredient.id,
      ingredient_id: owned_ingredient.ingredient_id,
      user_id: owned_ingredient.user_id}
  end

  def render("owned_ingredient.json", %{owned_ingredient: owned_ingredient}) do
    %{id: owned_ingredient.id,
      ingredient_id: owned_ingredient.ingredient_id,
      ingredient_name: owned_ingredient.ingredient_name,
      user_id: owned_ingredient.user_id}
  end
end
