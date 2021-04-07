 
defmodule CookingApp.User do
    alias CookingApp.UserHelper
    alias CookingApp.Room 

    def reg(gameName) do
        {:via, Registry, {CookingApp.Registry, gameName}}
    end

    def start(user) do
        spec = %{
            id: __MODULE__,
            start: {__MODULE__, :start_link, [user]},
            restart: :permanent,
            type: :worker,
        }
        CookingApp.Sup.start_child(spec);
    end 

    def start_link(username) do
        user = UserHelper.new(username)
        GenServer.start_link(__MODULE__, user, name: reg(username))
    end

    def handle_info({:update, username}, state) do
        Process.send_after(self(), {:update, username}, 30000)
        CookingApp.Endpoint.broadcast("room:" <> username, "view", Room.view())
        {:noreply, state}
    end  
end