defmodule CookingAppWeb.ApiView do
  use CookingAppWeb, :view
  alias CookingAppWeb.ApiView

  def render("index.json", %{ownedingredients: ownedingredients}) do
    %{data: render_many(ownedingredients, ApiView, "api.json")}
  end

  def render("show.json", %{owned_ingredient: owned_ingredient}) do
    %{data: render_one(owned_ingredient, ApiView, "api.json")}
  end

  def render("api.json", %{owned_ingredient: owned_ingredient}) do
    %{id: owned_ingredient.id}
  end
end