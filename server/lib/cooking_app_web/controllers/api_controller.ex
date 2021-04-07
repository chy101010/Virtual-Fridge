defmodule CookingAppWeb.ApiController do
    use CookingAppWeb, :controller

    alias CookingAppWeb.Helpers
    alias CookingAppWeb.Plugs

    plug Plugs.RequireAuth when action in [:index]
    action_fallback CookingAppWeb.FallbackController
    
    # Get ingredient search result from API
    #ingredient_params = {"ingredient_name", name}

    def searchResult(conn, %{"ingredient" => ingredient_params}) do
        case Helpers.getIngredientByName(ingredient_params["ingredient_name"]) do
        #TODO: SEND BACK INFO TO FRONTEND
            {:ok, result} ->
                IO.inspect(result)
                conn
                |> put_resp_content_type("application/json")
                |> send_resp(:ok, Jason.encode!(result))
                |>IO.inspect
            {:error, _} ->
                conn 
                |> put_resp_header("content-type", "application/json; charset=UTF-8")
                |> send_resp(:not_acceptable, Jason.encode!(%{error: "Given Ingredient Not Found."}))
        end
    end 
end