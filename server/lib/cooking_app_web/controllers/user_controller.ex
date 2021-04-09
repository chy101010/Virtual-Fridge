defmodule CookingAppWeb.UserController do
  use CookingAppWeb, :controller

  alias CookingApp.Users
  alias CookingApp.Users.User

  plug Plugs.RequireAuth when action in [:show]
  action_fallback CookingAppWeb.FallbackController

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Users.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    render(conn, "show.json", user: user)
  end
end
