defmodule CookingAppWeb.IngredientController do
  use CookingAppWeb, :controller

  alias CookingApp.Ingredients
  alias CookingApp.Ingredients.Ingredient
  alias CookingAppWeb.Plugs
  alias CookingAppWeb.Helpers

  # Room State
  alias CookingApp.Room

  plug Plugs.RequireAuth when action in [:index, :create, :show]
  action_fallback CookingAppWeb.FallbackController

   # Gets all the available ingredients in the database
  def index(conn, _params) do
    ingredients = Ingredients.list_ingredients()
    render(conn, "index.json", ingredients: ingredients)
  end

  
  # Creates ingredient
  # ingredient_params = {"ingredient_name", name}
  
  def create(conn, %{"ingredient" => ingredient_params}) do
    ingr = ingredient_params["ingredient_name"]

    db_ingredient = Ingredients.get_ingredient_by_name(ingr)
    if(!db_ingredient) do
      case Ingredients.create_ingredient(ingredient_params) do
        {:ok, result} ->
          Room.add_ingredient(Map.put(ingredient_params, "username", conn.assigns[:user].username))
          conn
          |> put_status(:created)
          |> put_resp_header("location", Routes.ingredient_path(conn, :show, ingredient_params["ingredient_name"]))
          |> render("show.json", ingredient: result)
        {:error, %Ecto.Changeset{} = changeset} ->
          conn
          |> put_resp_header("content-type", "application/json; charset=UTF-8")
          |> send_resp(:not_modified, Jason.encode!(%{error: changeset.errors}))
      end
    else
      conn
        |> put_resp_header("content-type", "application/json; charset=UTF-8")
        |> send_resp(:not_acceptable, Jason.encode!(%{error: "Given Ingredient Is Already in Database."}))
    end
  end
  
  # To Be Decided
  def show(conn, %{"id" => id}) do
    ingredient = Ingredients.get_ingredient!(id)
    if(ingredient) do
        render(conn, "show.json", ingredient: ingredient)
    else 
      conn
      |> put_resp_header("content-type", "application/json; charset=UTF-8")
      |> send_resp(:not_acceptable, Jason.encode!(%{error: "Given Ingredient Not Found."}))
    end 
  end

end
