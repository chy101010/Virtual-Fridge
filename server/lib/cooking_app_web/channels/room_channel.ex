defmodule CookingAppWeb.RoomChannel do
    use CookingAppWeb, :channel
    alias CookingApp.Server
    alias CookingApp.Room
   
    @impl true
    def join("main", payload, socket) do
        if authorized?(payload) do
            {:ok, Room.get_view(), socket}
        else 
            {:error, %{reason: "unauthorized"}}
        end
    end

    defp authorized?(_payload) do
        true
    end
end