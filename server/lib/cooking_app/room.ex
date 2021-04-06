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
        GenServer.call(:room, :view)
    end 
    
    def add_ingredient(ingredient) do
    
    end 

    def add_recipe(recipe) do
    
    end 

    @impl
    def handle_call(:view, _from, state) do
        IO.inspect("called Socket")
        {:reply, %{}, state}
    end 
end 