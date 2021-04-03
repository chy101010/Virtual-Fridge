defmodule CookingAppWeb.PageController do
  use CookingAppWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
