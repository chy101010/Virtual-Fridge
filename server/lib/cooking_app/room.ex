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

    @impl true
    def handle_call(:view, _from, state) do
        {:reply, RoomState.view(state), state}
    end 

    # Broadcast
    @impl true
    def handle_cast({:add_recipe, data}, state) do
        state = RoomState.add_recipe(state, data)
        CookingAppWeb.Endpoint.broadcast!("main", "view", %{new: data, data: RoomState.view(state)})
        {:noreply, state}
    end 

    # Broadcast 
    @impl true
    def handle_cast({:add_ingredient, data}, state) do
        state = RoomState.add_ingredient(state, data)
        CookingAppWeb.Endpoint.broadcast!("main", "view", %{new: data, data: RoomState.view(state)})
        {:noreply, state}
    end 
end 