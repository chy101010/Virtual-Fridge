defmodule CookingApp.OwnedIngredients.OwnedIngredient do
  use Ecto.Schema
  import Ecto.Changeset

  schema "ownedingredients" do
    field :user_id, :id
    field :ingredient_id, :id

    timestamps()
  end

  @doc false
  def changeset(owned_ingredient, attrs) do
    owned_ingredient
    |> cast(attrs, [:user_id, :ingredient_id])
    |> validate_required([:user_id, :ingredient_id])
  end
end
