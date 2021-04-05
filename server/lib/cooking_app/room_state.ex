defmodule CookingApp.RoomState do 
    
    def new() do
        %{
            recipes: [],
            ingredients: [],
        }
    end 

    def view(state) do
        %{
            recipes: state.recipes,
            ingredients: state.ingredients
        }
    end 


    def add_recipe(state, recipe) do
    
    end 

    def add_ingredient(state, ingredient) do
    
    end 

end 