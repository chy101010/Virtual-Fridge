defmodule CookingApp.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  alias CookingApp.Likes
  alias CookingApp.Dislikes
  alias CookingApp.Comments
  alias CookingApp.Users

  schema "posts" do
    field :body, :string
    field :photos, :string
    field :public, :boolean, default: false
    field :recipe, :string

    belongs_to :user, Users.User
    has_many :likes, Likes.Like
    has_many :dislikes, Dislikes.Dislike
    has_many :comments, Comments.Comment

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:body, :photos, :recipe, :public, :user_id])
    |> validate_required([:body, :photos, :recipe, :public, :user_id])
  end
end
