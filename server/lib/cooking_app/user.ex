 
defmodule CookingApp.User do
    alias CookingApp.UserHelper

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
    

    def start_link(user) do
        user = UserHelper.new(user)

    end


end