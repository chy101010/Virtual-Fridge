defmodule CookingApp.Repo.Migrations.CreateOwnedingredients do
  use Ecto.Migration

  def change do
    create table(:ownedingredients) do
      add :user_id, references(:users, on_delete: :delete_all), primary_key: true
      add :ingredient_id, references(:ingredients, on_delete: :delete_all), primary_key: true

      timestamps()
    end

    create unique_index(:ownedingredients, [:user_id, :ingredient_id], name: :user_id_ingredient_id_unique_index)
  end
end
