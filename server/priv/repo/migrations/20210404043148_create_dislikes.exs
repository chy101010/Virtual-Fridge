defmodule CookingApp.Repo.Migrations.CreateDislikes do
  use Ecto.Migration

  def change do
    create table(:dislikes) do
      add :user_id, references(:users, on_delete: :delete_all), primary_key: true
      add :post_id, references(:posts, on_delete: :delete_all), primary_key: true

      timestamps()
    end

  create unique_index(:likes, [:user_id, :post_id], name: :d_user_id_post_id_unique_index)
  end
end
