defmodule CookingApp.Server do
    def reg(gameName) do
        {:via, Registry, {Bulls.Registry, gameName}}
    end

    

    def start_link(email) do

    end

end