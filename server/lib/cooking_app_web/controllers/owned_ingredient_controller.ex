defmodule CookingAppWeb.OwnedIngredientController do
  use CookingAppWeb, :controller

  alias CookingApp.OwnedIngredients
  alias CookingApp.OwnedIngredients.OwnedIngredient

  action_fallback CookingAppWeb.FallbackController

  def index(conn, _params) do
    ownedingredients = OwnedIngredients.list_ownedingredients()
    render(conn, "index.json", ownedingredients: ownedingredients)
  end

  def create(conn, %{"owned_ingredient" => owned_ingredient_params}) do
    with {:ok, %OwnedIngredient{} = owned_ingredient} <- OwnedIngredients.create_owned_ingredient(owned_ingredient_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.owned_ingredient_path(conn, :show, owned_ingredient))
      |> render("show.json", owned_ingredient: owned_ingredient)
    end
  end

  def show(conn, %{"id" => id}) do
    owned_ingredient = OwnedIngredients.get_owned_ingredient!(id)
    render(conn, "show.json", owned_ingredient: owned_ingredient)
  end

  def update(conn, %{"id" => id, "owned_ingredient" => owned_ingredient_params}) do
    owned_ingredient = OwnedIngredients.get_owned_ingredient!(id)

    with {:ok, %OwnedIngredient{} = owned_ingredient} <- OwnedIngredients.update_owned_ingredient(owned_ingredient, owned_ingredient_params) do
      render(conn, "show.json", owned_ingredient: owned_ingredient)
    end
  end

  def delete(conn, %{"id" => id}) do
    owned_ingredient = OwnedIngredients.get_owned_ingredient!(id)

    with {:ok, %OwnedIngredient{}} <- OwnedIngredients.delete_owned_ingredient(owned_ingredient) do
      send_resp(conn, :no_content, "")
    end
  end
end
