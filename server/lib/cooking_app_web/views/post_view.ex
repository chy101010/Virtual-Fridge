defmodule CookingAppWeb.PostView do
  use CookingAppWeb, :view
  alias CookingAppWeb.PostView

  def render("index.json", %{posts: posts}) do
    %{data: render_many(posts, PostView, "post.json")}
  end

  def render("show.json", %{post: post}) do
    %{data: render_one(post, PostView, "post.json")}
  end

  def render("post.json", %{post: post}) do
    %{id: post.id,
      body: post.body,
      photos: post.photos,
      recipe: post.recipe,
      public: post.public}
  end
end
