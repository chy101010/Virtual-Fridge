defmodule CookingApp.Room do 
    # 
    def new(username) do
        %{
            ingredients: [],
            recipes: []
        }
    end 

    def view(state) do
        %{
            ingredients: state.ingredients,
            recipes: state.recipes
        }
    end 
end 