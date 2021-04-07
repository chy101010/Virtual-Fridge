defmodule CookingApp.Repo.Migrations.CreateIngredients do
  use Ecto.Migration

  def change do
    create table(:ingredients) do
      add :ingredient_name, :string, null: false
      add :spoonacular_id, :integer, null: false

      timestamps()
    end

  end
end
