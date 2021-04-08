defmodule CookingApp.OwnedIngredients.OwnedIngredient do
  alias CookingApp.Ingredients

  use Ecto.Schema
  import Ecto.Changeset

  schema "ownedingredients" do
    field :user_id, :id
    belongs_to :ingredient, Ingredients.Ingredient

    timestamps()
  end

  @doc false
  def changeset(owned_ingredient, attrs) do
    owned_ingredient
    |> cast(attrs, [:user_id, :ingredient_id])
    |> validate_required([:user_id, :ingredient_id])
    |> unique_constraint([:user_id, :ingredient_id], name: :user_id_ingredient_id_unique_index)
  end
end
