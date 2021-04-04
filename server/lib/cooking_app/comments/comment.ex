defmodule CookingApp.Comments.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  alias CookingApp.Users
  alias CookingApp.Posts

  schema "comments" do
    field :body, :string
    belongs_to :user, Users.User
    belongs_to :post, Posts.Post

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:body, :user_id, :event_id])
    |> validate_required([:body, :user_id, :event_id])
  end
end
