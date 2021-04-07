defmodule CookingApp.RoomState do 
    
    def new() do
        %{
            recipe_index: 0,
            recipes: [],
            ingredient_index: 0,
            ingredients: [],
        }
    end 

    def view(state) do
        %{
            recipes: state.recipes,
            ingredients: state.ingredients
        }
    end 

    # TODO: Polish 
    # recipe = %{username: username, recipe: recipe} 
    def add_recipe(state, recipe) do
        if(state.recipe_index == 50) do
            state1 = %{state | recipe_index: 0}
            %{state1 | receipes: List.replace_at(state1.receipes, state1.recipe_index, recipe)}
        else 
            state1 =  %{state | receipes: List.replace_at(state.receipes, state.recipe_index, recipe)}
            %{state1 | recipe_index: state1.recipe_index + 1}
        end 
    end 

    # ingredient = %{username: username, ingredient_name: ingredient_name}
    def add_ingredient(state, ingredient) do
        if(state.ingredient_index == 100) do
            state1 = %{state | ingredient_index: 0}
            %{state1 | ingredients: List.replace_at(state1.ingredients, state1.ingredient_index, ingredient)}
        else 
            state1 = %{state | ingredients: List.replace_at(state.ingredients, state.ingredient_index, ingredient)}
            %{state1 | ingredient_index: state1.ingredient_index + 1}
        end
    end 

end 