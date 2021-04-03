defmodule CookingApp.Repo.Migrations.CreateOwnedingredients do
  use Ecto.Migration

  def change do
    create table(:ownedingredients) do
      add :user_id, references(:users, on_delete: :delete_all), primary_key: true
      add :ingredient_name, references(:ingredients, on_delete: :delete_all), primary_key: true

      timestamps()
    end

    create unique_index(:ownedingredients, [:user_id, :ingredient_name], name: :user_id_ingredient_name_unique_index)
  end
end
