defmodule CookingAppWeb.Helpers do

    alias CookingApp.Ingredients

    #TODO make api key an environment variable
    def getApiKey() do
        #"88a684f43c204ecea33e2e0b904f7565"
        "9865beb9a15b40ea99aa5587374a8e47"
    end

    #given recipe id, returns {:status, result} where 
    #result = %{
        #id: recipe id
        #title: recipe name
        #image: recipe image url
        #sourceUrl: the url for the original recipe
    #}
    #error returns empty result
    def getRecipeById(id) do
        api_key = getApiKey()
        url = "https://api.spoonacular.com/recipes/#{id}/information?apiKey=#{api_key}&includeNutrition=true"
        resp = HTTPoison.get!(url)
        #if 200 status code
        if resp.status_code == 200 do
            data = Jason.decode!(resp.body)
            result = %{
                id: data["id"],
                title: data["title"],
                image: data["image"],
                sourceUrl: data["sourceUrl"],
            }
            {:ok, result}
        else
            result = %{}
            {:error, result}
        end
        
    end
    
    def getIngredientById(id) do
        api_key = getApiKey()
        url = "https://api.spoonacular.com/food/ingredients/#{id}/information?apiKey=#{api_key}&amount=1"
        resp = HTTPoison.get!(url)
        #if 200 status code
        if resp.status_code == 200 do
            data = Jason.decode!(resp.body)
            result = %{
                id: data["id"],
                name: data["original"],
                unit: data["unit"],
                cost: data["estimatedCost"],
                aisle: data["aisle"],
                nutrition: data["nutrition"]
            }
            {:ok, result}
        else
            result = %{}
            {:error, result}
        end
    end

    # converts a list to a comma separated string array
    # Input: [a, b, c, d, e, f]
    # Output: "a,b,c,d,e,f"
    def arrToString(arr, accum) do
        if arr == [] do
            String.slice(accum, 0..-2)
        else 
            cleanHead = String.replace((hd arr), " ", "%20") 
            arrToString((tl arr), cleanHead <> "," <> accum)
        end
    end

    #converts spoonacular's list of ingredients dict to list of ingredient names
    # Input: [%{
        #id: ...
        #name: "a"
    #},
    #%{
        #id: ...
        #name: "b"
    #}]
    #Output: [a, b]
    def cleanIngrList(data) do
        Enum.map(data, fn ing -> ing["name"] end)
    end

    #cleans spoonacular's list of ingredients dict to list of dicts with name and id
    def cleanIngrListWithId(data) do
        Enum.map(data, fn ing -> 
            %{"name": ing["name"], "id": ing["id"]} 
        end)
    end


    @doc """
    show receipe by an array of owned-ingredients
    Input: ["apple", "banana", "salt", "chicken"]
    Output: {:status, result} where
    result = [%{
        id: recipe id
        title: recipe name
        image: image url of recipe
        missedIngredients: list of missing ingredients 
        usedIngredients: list of used ingredients
        unusedIngredients: list of unused ingredients 
    },
    %{
        ...
    }]
    """
    def getRecipeByIngredients(ing) do
        api_key = getApiKey()
        ing_string = arrToString(ing, "")
        url = "https://api.spoonacular.com/recipes/findByIngredients?apiKey=#{api_key}&ingredients=#{ing_string}"
        resp = HTTPoison.get!(url)
        if resp.status_code == 200 do
            data = Jason.decode!(resp.body)
            result = Enum.map(data, fn rcpe -> %{
                id: rcpe["id"],
                title: rcpe["title"],
                image: rcpe["image"],
                missedIngredients: cleanIngrList(rcpe["missedIngredients"]),
                usedIngredients: cleanIngrList(rcpe["usedIngredients"]),
                unusedIngredients: cleanIngrList(rcpe["unusedIngredients"])
            } end)
            {:ok, result}
        else
            result = %{}
            {:error, result}
        end
    end

    @doc """
    show a single ingredient by name ~~~
    {:status, result} where
    result = [%{
        id: ingredient id
        name: ingredient name
        image: ingredient image
    },
    %{
        ...
    }]
    """
    def getIngredientByName(name) do
        api_key = getApiKey()
        url = "https://api.spoonacular.com/food/ingredients/autocomplete?apiKey=#{api_key}&query=#{name}&number=10&metaInformation=true"
        resp = HTTPoison.get!(url)
        if resp.status_code == 200 do
            data = Jason.decode!(resp.body)
            result = %{
                results: cleanIngrListWithId(data)
            }
            {:ok, result}
        else
            result = %{}
            {:error, result}
        end
    end 

    #Converts OwnedIngredient obj to ingredient name in a list
    def ingredientListObjToName(list) do
        Enum.map(list, fn ing ->
            Ingredients.get_ingredient!(ing.ingredient_id).ingredient_name
        end)
    end
end