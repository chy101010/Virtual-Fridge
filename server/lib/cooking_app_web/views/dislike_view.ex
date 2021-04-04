defmodule CookingAppWeb.DislikeView do
  use CookingAppWeb, :view
  alias CookingAppWeb.DislikeView

  def render("index.json", %{dislikes: dislikes}) do
    %{data: render_many(dislikes, DislikeView, "dislike.json")}
  end

  def render("show.json", %{dislike: dislike}) do
    %{data: render_one(dislike, DislikeView, "dislike.json")}
  end

  def render("dislike.json", %{dislike: dislike}) do
    %{id: dislike.id}
  end
end
