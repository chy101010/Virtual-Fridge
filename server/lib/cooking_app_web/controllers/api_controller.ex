defmodule CookingAppWeb.ApiController do
    use CookingAppWeb, :controller

    alias CookingAppWeb.Helpers
    alias CookingApp.OwnedIngredients
    alias CookingApp.Ingredients
    alias CookingAppWeb.Plugs
    
    # Socket
    alias CookingApp.Room

    plug Plugs.RequireAuth when action in [:searchResult, :getRecipeByIngredients]
    action_fallback CookingAppWeb.FallbackController


    #This controller contains functions that call the Spoonacular API
    
    # Given a string query, return a list of ingredients from the Spoonacular db of ingredients.
    #ingredient_params = {"ingredient_name", name}
    def searchResult(conn, %{"ingredient" => ingredient_params}) do

        #call helper function with appropriate endpoint
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

    defp loop_broadcast_recipe(recipes, start, dest) do
        if(start < dest) do
            Room.add_recipe(Enum.at(recipes, start))
            loop_broadcast_recipe(recipes, start + 1, dest)
        else 
            0
        end 
    end  

    #Returns a list of recipes using the list of owned ingredients
    def getRecipeByIngredients(conn, _) do
        #get user id
        user_id = conn.assigns[:user].id
        #get ingredients owned by user
        ingredients = OwnedIngredients.get_owned_ingredient_by_user_id(user_id)
        #change list of ingredient objects into list of ingredient names
        ingredients = Helpers.ingredientListObjToName(ingredients)

        #if not empty
        if(ingredients != []) do

            #call helper function with appropriate endpoint
            case Helpers.getRecipeByIngredients(ingredients) do
                {:ok, result} ->
                    recipes = Enum.map(result, fn recipe -> %{"username": conn.assigns[:user].username, "recipe_name": recipe.title} end)
                    loop_broadcast_recipe(recipes, 0, length(recipes))
                    conn 
                    |> put_resp_header("content-type", "application/jsonl charset=UTF-8")
                    |> send_resp(:ok, Jason.encode!(result))
                {:error, _} ->
                    conn 
                    |> put_resp_header("content-type", "application/json; charset=UTF-8")
                    |> send_resp(:not_acceptable, Jason.encode!(%{error: "API Error"}))
            end
        else 
            conn
            |> put_resp_header("content-type", "application/jsonl charset=UTF-8")
            |> send_resp(:not_found, Jason.encode!(%{error: "You Don't Have Ingredients"}))
        end
    end

    # Given a spoonacular recipe id, return information about the recipe.
    # recipe_params = {"id": id}
    def recipeInfo(conn, %{"recipe" => recipe_params}) do
        recipe_id = recipe_params["id"]

        #call helper function with appropriate endpoint
        case Helpers.getRecipeById(recipe_id) do
            {:ok, result} ->
                conn 
                |> put_resp_header("content-type", "application/jsonl charset=UTF-8")
                |> send_resp(:ok, Jason.encode!(result))
            {:error, _} ->
                conn 
                |> put_resp_header("content-type", "application/json; charset=UTF-8")
                |> send_resp(:not_acceptable, Jason.encode!(%{error: "API Error"}))
        end
    end

    # Given an owned ingredient id, return information about the ingredient.
    # ingredient_params = {"id": id}
    def ingredientInfoByIngId(conn, %{"ingredient" => ingredient_params}) do
        #get owned ingredient id
        ingredient_id = ingredient_params["id"]

        #get spoonacular id by joining owned ingredients and ingredients table
        spoonacular_id = Ingredients.get_spoonacular_id_by_ingredient_id(ingredient_id)

        #if there is an element in list of spoonacular ids, 
        if(hd spoonacular_id) do

            #call helper function with appropriate endpoint
            case Helpers.getIngredientById(hd spoonacular_id) do
            {:ok, result} ->
                conn 
                |> put_resp_header("content-type", "application/jsonl charset=UTF-8")
                |> send_resp(:ok, Jason.encode!(result))
            {:error, _} ->
                conn 
                |> put_resp_header("content-type", "application/json; charset=UTF-8")
                |> send_resp(:not_acceptable, Jason.encode!(%{error: "API Error"}))
            end
        else
            conn
            |> put_resp_header("content-type", "application/json; charset=UTF-8")
            |> send_resp(:not_acceptable, Jason.encode!(%{error: "Error with querying"}))
        end
    end
    
    # Given a spoonacular ingredient id, get ingredient information
    # ingredient_params = {"id", id}
    def ingredientInfo(conn, %{"ingredient" => ingredient_params}) do
        spoonacular_id = ingredient_params["id"]

        #call helper function with appropriate endpoint
        case Helpers.getIngredientById(spoonacular_id) do
            {:ok, result} ->
                conn 
                |> put_resp_header("content-type", "application/jsonl charset=UTF-8")
                |> send_resp(:ok, Jason.encode!(result))
            {:error, _} ->
                conn 
                |> put_resp_header("content-type", "application/json; charset=UTF-8")
                |> send_resp(:not_acceptable, Jason.encode!(%{error: "API Error"}))
        end
    end
end