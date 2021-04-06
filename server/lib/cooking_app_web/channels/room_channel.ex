defmodule CookingAppWeb.RoomChannel do
    use CookingAppWeb, :channel
    alias CookingApp.Server
   
    @impl true
    def join("room:" <> user, payload, socket) do
        # TODO: Authenticate the user 
        if authorized?(payload) do
            {:ok, socket}
        else 
            {:error, %{reason: "unauthorized"}}
        end
    end


    defp authorized?(_payload) do
        true
    end
end