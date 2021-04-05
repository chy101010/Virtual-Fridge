defmodule CookingApp.Sup do
    use DynamicSupervisor
    
    def init(:ok) do
        DynamicSupervisor.init(strategy: :one_for_one)
    end

    def start_child(spec) do
        DynamicSupervisor.start_child(__MODULE__, spec);
    end
end