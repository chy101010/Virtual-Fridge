defmodule CookingAppWeb.Plugs.RequireAuth do
    import Plug.Conn

    def init(args), do: args

    def call(conn, _args) do
      IO.inspect("call plug")
      token = Enum.at(get_req_header(conn, "x-auth"), 0)
      IO.inspect(token)
      case Phoenix.Token.verify(conn, "user_id",
            token, max_age: 86400) do
        {:ok, user_id} ->
          user = CookingAppWeb.Users.get_user!(user_id)
          assign(conn, :user, user)
        {:error, err} ->
          conn
          |> put_resp_header("content-type", "application/json; charset=UTF-8")
          |> send_resp(:unauthorized, Jason.encode!(%{"error" => err}))
          |> halt()
    end
  end
end