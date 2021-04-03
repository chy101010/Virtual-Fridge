defmodule CookingAppWeb.OwnedIngredientView do
  use CookingAppWeb, :view
  alias CookingAppWeb.OwnedIngredientView

  def render("index.json", %{ownedingredients: ownedingredients}) do
    %{data: render_many(ownedingredients, OwnedIngredientView, "owned_ingredient.json")}
  end

  def render("show.json", %{owned_ingredient: owned_ingredient}) do
    %{data: render_one(owned_ingredient, OwnedIngredientView, "owned_ingredient.json")}
  end

  def render("owned_ingredient.json", %{owned_ingredient: owned_ingredient}) do
    %{id: owned_ingredient.id}
  end
end
