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
            add_recipe_helper(state1, recipe)
        else 
            state1 = add_recipe_helper(state, recipe)
            %{state1 | recipe_index: state1.recipe_index + 1}
        end 
    end 

    defp add_recipe_helper(state, recipe) do
        if(state.recipe_index < length(state.receipes)) do
            %{state | receipes: List.replace_at(state.receipes, state.recipe_index, recipe)}
        else
            %{state | receipes: state.recipes ++ [recipe]}
        end
    end

    # ingredient = %{username: username, ingredient_name: ingredient_name}
    def add_ingredient(state, ingredient) do
        if(state.ingredient_index == 100) do
            state1 = %{state | ingredient_index: 0}
            add_ingredient_helper(state1, ingredient)
        else 
            state1 = add_ingredient_helper(state, ingredient)
            %{state1 | ingredient_index: state1.ingredient_index + 1}
        end
    end 

    defp add_ingredient_helper(state, ingredient) do
        if(state.ingredient_index < length(state.ingredients)) do
            %{state | ingredients: List.replace_at(state.ingredients, state.ingredient_index, ingredient)}
        else
            %{state | ingredients: state.ingredients ++ [ingredient]}
        end
    end

end 