defmodule CookingApp.Setup do
    use Supervisor

    def start_link(_arg) do
        Supervisor.start_link(__MODULE__, :ok);
    end

    @impl true
    def init(:ok) do
        children = [
            {CookingApp.Room, name: CookingApp.Room}
        ]
        Supervisor.init(children, strategy: :one_for_one)
    end
end