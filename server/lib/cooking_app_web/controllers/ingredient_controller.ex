defmodule CookingAppWeb.IngredientController do
  use CookingAppWeb, :controller

  alias CookingApp.Ingredients
  alias CookingApp.Ingredients.Ingredient
  alias CookingAppWeb.Plugs

  plug Plugs.RequireAuth when action in [:index, :create, :show]
  action_fallback CookingAppWeb.FallbackController

   # Gets all the available ingredients in the database
  def index(conn, _params) do
    ingredients = Ingredients.list_ingredients()
    render(conn, "index.json", ingredients: ingredients)
  end

  
  # Creates ingredient
  # ingredient_params = {"name", name}
  def create(conn, %{"ingredient" => ingredient_params}) do
    #check the result from API
    case getIngredientByName(ingredient_params["name"]) do
      #if API returns a valid resp
      {:ok, result} ->
        #if the list of possible ingredients are not empty
        if(result != []) do
          #convert list of ingredients into string names
          ingr_list = Enum.map(result, fn ing -> ing["name"] end)
          #Add item to db if it is not in db and return true, else false.
          status_list = Enum.map(ingr_list, fn ing ->
            db_ingredient = Ingredients.get_ingredient_by_name(ing)
            if(!db_ingredient) do
              params = %{ingredient_name: ing}
              Ingredients.create_ingredient(params)
              true
            else
              false
            end
          end)
          #if status_list is all false, then that means all possible ingredients are already in the db
          if Enum.all?(status_list, fn status -> !status end) do
            conn
            |> put_resp_header("content-type", "application/json; charset=UTF-8")
            |> send_resp(:not_acceptable, Jason.encode!(%{error: "All variations of the ingredient are in the database."}))
          else
            conn
            |> put_status(:created)
            |> put_resp_header("location", Routes.ingredient_path(conn, :show, ingredient))
            |> render("show.json", owned_ingredient: result)
          end
        #if results is empty
        else 
          conn
          |> put_resp_header("content-type", "application/json; charset=UTF-8")
          |> send_resp(:not_acceptable, Jason.encode!(%{error: "Given Ingredient Not Found."}))
        end
    #error from API
    {:error, _} ->
        conn
        |> put_resp_header("content-type", "application/json; charset=UTF-8")
        |> send_resp(:not_acceptable, Jason.encode!(%{error: "Error with the API"}))
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
