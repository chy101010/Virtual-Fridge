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
    
    def add_ingredient(data) do
        GenServer.cast(:room, {:add_ingredient, data})
    end 

    def add_recipe(data) do
        GenServer.cast(:room, {:add_recipe, data})
    end 

    @impl
    def handle_call(:view, _from, state) do
        IO.inspect("called Handle_call Room View")
        {:noreply, state}
    end 

    @impl 
    def handle_cast({:add_recipe, data}, _from, state) do
        IO.inspect("called Handle_cast add receipe")
        {:noreply, RoomState.add_recipe(state, data)}
    end 

    def handle_cast({:add_ingredient, data}, _from, state) do
        IO.inspect("called Handle_cast add receipe")
        {:noreply, RoomState.add_ingredient(state, data)}
    end 
end 