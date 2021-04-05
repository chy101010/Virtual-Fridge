 
defmodule CookingApp.Server do
    def reg(gameName) do
        {:via, Registry, {CookingApp.Registry, gameName}}
    end

    

    def start_link(email) do

    end

end