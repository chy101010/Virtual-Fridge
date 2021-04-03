defmodule CookingApp.OwnedIngredients.OwnedIngredient do
  use Ecto.Schema
  import Ecto.Changeset

  schema "ownedingredients" do
    field :user_id, :id
    field :ingredient_name, :id

    timestamps()
  end

  @doc false
  def changeset(owned_ingredient, attrs) do
    owned_ingredient
    |> cast(attrs, [])
    |> validate_required([])
  end
end
