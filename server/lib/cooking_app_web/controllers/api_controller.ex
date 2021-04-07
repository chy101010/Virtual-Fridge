defmodule CookingAppWeb.ApiController do
    use CookingAppWeb, :controller

    alias CookingAppWeb.Helpers
    alias CookingApp.OwnedIngredients
    alias CookingAppWeb.Plugs

    plug Plugs.RequireAuth when action in [:searchResult, :getRecipeByIngredients]
    action_fallback CookingAppWeb.FallbackController
    
    # Get ingredient search result from API
    #ingredient_params = {"ingredient_name", name}

    def searchResult(conn, %{"ingredient" => ingredient_params}) do
        case Helpers.getIngredientByName(ingredient_params["ingredient_name"]) do
            {:ok, result} ->
                conn
                |> put_resp_content_type("application/json")
                |> send_resp(:ok, Jason.encode!(result))
            {:error, _} ->
                conn 
                |> put_resp_header("content-type", "application/json; charset=UTF-8")
                |> send_resp(:not_acceptable, Jason.encode!(%{error: "Given Ingredient Not Found."}))
        end
    end 

    def getRecipeByIngredients(conn, _) do
        user_id = conn.assigns[:user].id
        ingredients = OwnedIngredients.get_owned_ingredient_by_user_id(user_id)
        ingredients = Helpers.ingredientListObjToName(ingredients)
        IO.inspect(ingredients)
        #TODO: parse ingredients into list of ingredients 
        if(ingredients != []) do
            case Helpers.getRecipeByIngredients(ingredients) do
                {:ok, result} ->
                    conn 
                    |> put_resp_header("content-type", "application/jsonl charset=UTF-8")
                    |> send_resp(:ok, Jason.encode!(result))
                {:error, _} ->
                    conn 
                    |> put_resp_header("content-type", "application/json; charset=UTF-8")
                    |> send_resp(:not_acceptable, Jason.encode!(%{error: "Given Ingredient Not Found."}))
            end
        else 
            conn
            |> put_resp_header("content-type", "application/jsonl charset=UTF-8")
            |> send_resp(:not_found, Jason.encode!(%{error: "You Don't Have Ingredients"}))
        end
    end
end