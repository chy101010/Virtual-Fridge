defmodule CookingApp.Room do 
    use GenServer

    alias CookingApp.RoomState

    @impl true
    def init(arg) do
        {:ok, arg}
    end 

    def start_link(_arg) do
        GenServer.start_link(__MODULE__, RoomState.new(), name: :room)
    end 

    def get_view() do
    
    end 
    
    def add_ingredient(ingredient) do
    
    end 

    def add_recipe(recipe) do
    
    end 
end 