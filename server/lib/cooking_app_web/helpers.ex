defmodule CookingAppWeb.Helpers do

    #TODO make api key an environment variable
    def getApiKey() do
        "88a684f43c204ecea33e2e0b904f7565"
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
        url = "https://api.spoonacular.com/recipes/716429/information?apiKey=#{api_key}&includeNutrition=true"
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

    # converts a list to a comma separated string array
    # Input: [a, b, c, d, e, f]
    # Output: "a,b,c,d,e,f"
    def arrToString(arr, accum) do
        if arr == [] do
            String.slice(accum, 0..-2)
        else 
            arrToString((tl arr), accum <> "," <> (hd arr))
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
        url = "https://api.spoonacular.com/food/ingredients/search?apiKey=#{api_key}&query=#{name}"
        resp = HTTPoison.get!(url)
        if resp.status_code == 200 do
            data = Jason.decode!(resp.body)
            result = %{
                results: data["results"]
            }
            {:ok, result}
        else
            result = %{}
            {:error, result}
        end
    end 
    # show a single ingredient by id
end