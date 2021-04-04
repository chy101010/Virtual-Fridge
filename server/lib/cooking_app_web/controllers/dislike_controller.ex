defmodule CookingAppWeb.DislikeController do
  use CookingAppWeb, :controller

  alias CookingApp.Dislikes
  alias CookingApp.Dislikes.Dislike

  action_fallback CookingAppWeb.FallbackController

  def index(conn, _params) do
    dislikes = Dislikes.list_dislikes()
    render(conn, "index.json", dislikes: dislikes)
  end

  def create(conn, %{"dislike" => dislike_params}) do
    with {:ok, %Dislike{} = dislike} <- Dislikes.create_dislike(dislike_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.dislike_path(conn, :show, dislike))
      |> render("show.json", dislike: dislike)
    end
  end

  def show(conn, %{"id" => id}) do
    dislike = Dislikes.get_dislike!(id)
    render(conn, "show.json", dislike: dislike)
  end

  def update(conn, %{"id" => id, "dislike" => dislike_params}) do
    dislike = Dislikes.get_dislike!(id)

    with {:ok, %Dislike{} = dislike} <- Dislikes.update_dislike(dislike, dislike_params) do
      render(conn, "show.json", dislike: dislike)
    end
  end

  def delete(conn, %{"id" => id}) do
    dislike = Dislikes.get_dislike!(id)

    with {:ok, %Dislike{}} <- Dislikes.delete_dislike(dislike) do
      send_resp(conn, :no_content, "")
    end
  end
end
