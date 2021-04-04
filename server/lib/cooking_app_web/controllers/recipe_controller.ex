defmodule CookingAppWeb.RecipeController do
    use CookingAppWeb, :controller

    alias CookingApp.OwnedIngredients
    alias CookingApp.OwnedIngredients.OwnedIngredient
    alias CookingApp.Ingredients
    alias CookingAppWeb.Plugs

    plug Plugs.RequireAuth when action in [:index]
    action_fallback CookingAppWeb.FallbackController
    
    # Get all the a recipe that is available to the current user  
    def index(conn, _params) do
        user_id = conn.assigns[:user].id
        ingredients = OwnedIngredients.get_owned_ingredient_by_user_id(user_id)
        if(ingredients) do
            recipes = getRecipeByIngredients(ingredients)
            conn 
            |> put_resp_header("content-type", "application/jsonl charset=UTF-8")
            |> send_resp(:ok, Jason.encode!(%{data: recipes}))
        else 
            conn
            |> put_resp_header("content-type", "application/jsonl charset=UTF-8")
            |> send_resp(:not_found, Jason.encode!(%{error: "You Don't Have Ingredients"}))
        end
    end 
end