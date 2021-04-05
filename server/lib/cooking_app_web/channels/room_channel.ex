defmodule CookingAppWeb.RoomChannel do
    use CookingAppWeb, :channel
    alias CookingApp.Server
   
    @impl true
    def join("room:" <> username, payload, socket) do
        # TODO: Authenticate the user 
        if authorized?(payload) do
            
        else 
            {:error, %{reason: "unauthorized"}}
        end
    end


    defp authorized?(_payload) do
        true
    end
end