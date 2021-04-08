defmodule CookingAppWeb.OwnedIngredientController do
  use CookingAppWeb, :controller
 
  alias CookingApp.OwnedIngredients
  alias CookingApp.OwnedIngredients.OwnedIngredient
  alias CookingApp.Ingredients
  alias CookingAppWeb.Plugs

  # Room process
  alias CookingApp.Room
 
  plug Plugs.RequireAuth when action in [:index, :create, :show, :delete]
  action_fallback CookingAppWeb.FallbackController
 
 
  # Gets all the owned_ingredient of the current user
  def index(conn, _params) do
    user_id = conn.assigns[:user].id
    ownedingredients = get_ingredient_names(OwnedIngredients.get_owned_ingredient_by_user_id(user_id))
    render(conn, "index.json", ownedingredients: ownedingredients)
  end

  defp get_ingredient_names(l) do
    if length(l) == 0 do
      []
    else
      [Map.put(hd(l), :ingredient_name, Ingredients.get_ingredient!(hd(l).ingredient_id).ingredient_name)] ++ get_ingredient_names(tl(l))
    end
  end
 
  # Creates owned_ingredient
  # owned_ingredient_params = {"ingredient_name": ingredient_name}
  # Checks whether the ingredient's name is valid and the current user doesn't have a duplicate  
  def create(conn, %{"owned_ingredient" => owned_ingredient_params}) do
    #get user id
    user_id = conn.assigns[:user].id

    #get ingredient from ingredients database
    ingredient_id = Ingredients.get_ingredient_by_name(owned_ingredient_params["ingredient_name"]);

    #if ingredient is in the ingredients database, we can add it to owned ingredients
    if(ingredient_id) do
      params = %{"user_id": user_id, "ingredient_id": ingredient_id.id}
      res = OwnedIngredients.create_owned_ingredient(params)
      case res do
        {:ok, result} ->
          conn
          |> put_status(:created)
          |> put_resp_header("location", Routes.owned_ingredient_path(conn, :show, result))
          |> render("show.json", owned_ingredient: result)
        {:error, %Ecto.Changeset{} = changeset} ->
          conn 
          |> put_resp_header("content-type", "application/json; charset=UTF-8")
          |> send_resp(:not_acceptable, Jason.encode!(%{error: "Given Ingredient Not Invalid."}))
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
  # Checks whether the current user has that ingredient 
  def delete(conn, %{"id" => id}) do
    #get user id
    user_id = conn.assigns[:user].id

    #get owned ingredient
    owned_ingredient = OwnedIngredients.get_owned_ingredient!(String.to_integer(id))

    #if owned ingredient exists
    if(owned_ingredient) do

      #if the owner is the same as the logged in user
      if(owned_ingredient.user_id === user_id) do
        #try deleting the owned ingredient
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
