defmodule CookingAppWeb.RoomChannel do
    use CookingAppWeb, :channel
    alias CookingApp.Server
   
    @impl true
    def join("room:" <> user, payload, socket) do
        if authorized?(payload) do
            {:ok, socket}
        else 
            {:error, %{reason: "unauthorized"}}
        end
    end

    # Interval update  

    # Instand update

    @impl true
    def handle_in("receipes", _payload, socket) do
        {:noreply, socket}
    end 

    @impl true
    def handle_in("ingredients", _payload, socket) do
        {:noreply, socket}
    end 


    defp authorized?(_payload) do
        true
    end
end