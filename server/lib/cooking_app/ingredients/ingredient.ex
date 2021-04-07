defmodule CookingApp.Ingredients.Ingredient do
  use Ecto.Schema
  import Ecto.Changeset

  schema "ingredients" do
    field :ingredient_name, :string
    field :spoonacular_id, :integer

    many_to_many :user, CookingApp.Users.User, join_through: CookingApp.OwnedIngredients.OwnedIngredient, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(ingredient, attrs) do
    ingredient
    |> cast(attrs, [:ingredient_name, :spoonacular_id])
    |> validate_required([:ingredient_name, :spoonacular_id])
  end
end
