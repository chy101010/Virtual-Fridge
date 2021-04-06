defmodule CookingAppWeb.RoomChannel do
    use CookingAppWeb, :channel
    alias CookingApp.Server
   
    @impl true
    def join("room:" <> user, payload, socket) do
        if authorized?(payload) do
            IO.puts("called");
            {:ok, socket}
        else 
            {:error, %{reason: "unauthorized"}}
        end
    end


    defp authorized?(_payload) do
        true
    end
end