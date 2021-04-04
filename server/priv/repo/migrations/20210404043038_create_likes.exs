defmodule CookingApp.Repo.Migrations.CreateLikes do
  use Ecto.Migration

  def change do
    create table(:likes) do
      add :user_id, references(:users, on_delete: :nothing), primary_key: true
      add :post_id, references(:posts, on_delete: :nothing), primary_key: true

      timestamps()
    end

    create unique_index(:likes, [:user_id, :post_id], name: :l_user_id_post_id_unique_index)
  end
end
