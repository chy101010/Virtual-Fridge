defmodule CookingAppWeb.SessionController do
  use CookingAppWeb, :controller

  def create(conn, %{"username" => username, "password" => password}) do
    user = CookingApp.Users.authenticate(username, password)

    if user do
      sess = %{
        user_id: user.id,
        username: user.username,
        token: Phoenix.Token.sign(conn, "user_id", user.id),
      }

      conn
      |> put_resp_header("content-type", "application/json; charset=UTF-8")
      |> send_resp(:created, Jason.encode!(%{session: sess}))
    else
      conn
      |> put_resp_header("content-type", "application/json; charset=UTF-8")
      |> send_resp(:unauthorized, Jason.encode!(%{error: "Login Failed."}))
    end
  end
end
