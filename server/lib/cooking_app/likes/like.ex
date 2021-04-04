defmodule CookingApp.Likes.Like do
  use Ecto.Schema
  import Ecto.Changeset

  alias CookingApp.Users
  alias CookingApp.Posts

  schema "likes" do
    belongs_to :user, Users.User
    belongs_to :post, Posts.Post

    timestamps()
  end

  @doc false
  def changeset(like, attrs) do
    like
    |> cast(attrs, [:user_id, :post_id])
    |> validate_required([:user_id, :post_id])
  end
end
