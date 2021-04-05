defmodule CookingApp.Sup do
    def start_child(spec) do
        DynamicSupervisor.start_child(__MODULE__, spec);
    end
end