defmodule CookingApp.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :password_hash, :string
    field :username, :string

    many_to_many :ingredients, CookingApp.Ingredients.Ingredient, join_through: CookingApp.OwnedIngredients.OwnedIngredient, on_replace: :delete
    
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    #attrs = Map.put(attrs, "password_hash", attrs["password"]);
    #user
    #|> cast(attrs, [:username, :first_name, :last_name, :password_hash])
    #|> validate_required([:username, :first_name, :last_name, :password_hash]) 
    user
    |> cast(attrs, [:username, :first_name, :last_name])
    |> add_password_hash(attrs["password"])
    |> validate_required([:username, :first_name, :last_name, :password_hash])
  end

  def add_password_hash(cset, nil) do
    cset
  end

  def add_password_hash(cset, password) do
    change(cset, Argon2.add_hash(password))
    #change(cset, password)
  end
end
