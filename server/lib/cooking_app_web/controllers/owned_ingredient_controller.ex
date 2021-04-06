defmodule CookingAppWeb.OwnedIngredientController do
  use CookingAppWeb, :controller
 
  alias CookingApp.OwnedIngredients
  alias CookingApp.OwnedIngredients.OwnedIngredient
  alias CookingApp.Ingredients
  alias CookingAppWeb.Plugs
 
  #plug Plugs.RequireAuth when action in [:index, :create, :show, :delete]
  action_fallback CookingAppWeb.FallbackController
 
 
  # Gets all the owned_ingredient of the current user
  def index(conn, _params) do
    user_id = conn.assigns[:user].id
    ownedingredients = OwnedIngredients.get_owned_ingredient_by_user_id(user_id)
    render(conn, "index.json", ownedingredients: ownedingredients)
  end
 
  # Creates owned_ingredient
  # owned_ingredient_params = {"ingredient_name": ingredient_name}
  # Checks whether the ingredient's name is valid and the current user doesn't have a duplicate  
  def create(conn, %{"owned_ingredient" => owned_ingredient_params}) do
    user_id = conn.assigns[:user].id
    ingredient_id = Ingredients.get_ingredient_id_by_name(owned_ingredient_params["ingredient_name"]);
    if(ingredient_id) do
      params = %{"user_id": user_id, "ingredient_id": ingredient_id.id}
      IO.inspect "PARAMS"
      IO.inspect(params)
      res = OwnedIngredients.create_owned_ingredient(params)
      IO.inspect "RES"
      IO.inspect(res)
      case res do
        {:ok, result} ->
          conn
          |> put_status(:created)
          |> put_resp_header("location", Routes.owned_ingredient_path(conn, :show, result))
          |> render("show.json", owned_ingredient: result)
        {:error, %Ecto.Changeset{} = changeset} ->
          conn 
          |> put_resp_header("content-type", "application/json; charset=UTF-8")
          |> send_resp(:not_acceptable, Jason.encode!(%{error: "Given Ingredient Not Found."}))
      end 
    else
      conn
      |> put_resp_header("content-type", "application/json; charset=UTF-8")
      |> send_resp(:not_acceptable, Jason.encode!(%{error: "Given Ingredient Not Found."}))
    end 
  end
 
  # Shows the info of a owned ingredients 
  # Checks whether the id is valid 
  # Checks whether the current user has that ingredient - plug?
  def show(conn, %{"id" => id}) do
    user_id = conn.assigns[:user].id
    owned_ingredient = OwnedIngredients.get_owned_ingredient!(id)
    if(owned_ingredient) do
      if(owned_ingredient.user.id === user_id) do
        # TODO API CALL AND SEND BACK INGREDIENT INFO
        conn
        |> render("show.json", owned_ingredient: owned_ingredient)
      else 
        conn
        |> put_resp_header("content-type", "application/json; charset=UTF-8")
        |> send_resp(:unauthorized, Jason.encode!(%{error: "Not Yours."}))
      end 
    else 
      conn
      |> put_resp_header("content-type", "application/json; charset=UTF-8")
      |> send_resp(:not_acceptable, Jason.encode!(%{error: "Given Ingredient Not Found."}))
    end 
  end
 
  # Deletes the info of a owned ingredients 
  # Checks whether the id is valid 
  # Checks whether the current user has that ingredient - plug?
  def delete(conn, %{"id" => id}) do
    user_id = conn.assigns[:user].id
    owned_ingredient = OwnedIngredients.get_owned_ingredient!(id)
    if(owned_ingredient) do
      if(owned_ingredient.user.id === user_id) do
        case OwnedIngredients.delete_owned_ingredient(owned_ingredient) do
          {:ok, %OwnedIngredient{}} ->
            send_resp(conn, :no_content, "")
          {:error, changeset} ->
            conn
            |> put_resp_header("content-type", "application/json; charset=UTF-8")
            |> send_resp(:unauthorized, Jason.encode!(%{error: changeset.errors}))
        end 
      else 
        conn
        |> put_resp_header("content-type", "application/json; charset=UTF-8")
        |> send_resp(:unauthorized, Jason.encode!(%{error: "Not Yours."}))
      end 
    else
      conn 
      |> put_resp_header("content-type", "application/json; charset=UTF-8")
      |> send_resp(:not_acceptable, Jason.encode!(%{error: "Given Ingredient Not Found."})) 
    end 
  end
end
