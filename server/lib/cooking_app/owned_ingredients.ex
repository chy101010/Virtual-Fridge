defmodule CookingApp.OwnedIngredients do
  @moduledoc """
  The OwnedIngredients context.
  """

  import Ecto.Query, warn: false
  alias CookingApp.Repo

  alias CookingApp.OwnedIngredients.OwnedIngredient

  @doc """
  Returns the list of ownedingredients.

  ## Examples

      iex> list_ownedingredients()
      [%OwnedIngredient{}, ...]

  """
  def list_ownedingredients do
    Repo.all(OwnedIngredient)
  end

  @doc """
  Gets a single owned_ingredient.

  Raises `Ecto.NoResultsError` if the Owned ingredient does not exist.

  ## Examples

      iex> get_owned_ingredient!(123)
      %OwnedIngredient{}

      iex> get_owned_ingredient!(456)
      ** (Ecto.NoResultsError)

  """
  #def get_owned_ingredient!(id), do: Repo.get!(OwnedIngredient, id)

   def get_owned_ingredient!(id) do
     Repo.get!(OwnedIngredient, id)
   end

   def get_owned_ingredient_by_user_id(user_id) do
     query = from(OwnedIngredient, where: [user_id: ^user_id])
     Repo.all(query)
   end

  @doc """
  Creates a owned_ingredient.

  ## Examples

      iex> create_owned_ingredient(%{field: value})
      {:ok, %OwnedIngredient{}}

      iex> create_owned_ingredient(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_owned_ingredient(attrs \\ %{}) do
    IO.inspect("create owned ingredient")
    IO.inspect(attrs)
    %OwnedIngredient{}
    |> OwnedIngredient.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a owned_ingredient.

  ## Examples

      iex> update_owned_ingredient(owned_ingredient, %{field: new_value})
      {:ok, %OwnedIngredient{}}

      iex> update_owned_ingredient(owned_ingredient, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_owned_ingredient(%OwnedIngredient{} = owned_ingredient, attrs) do
    owned_ingredient
    |> OwnedIngredient.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a owned_ingredient.

  ## Examples

      iex> delete_owned_ingredient(owned_ingredient)
      {:ok, %OwnedIngredient{}}

      iex> delete_owned_ingredient(owned_ingredient)
      {:error, %Ecto.Changeset{}}

  """
  def delete_owned_ingredient(%OwnedIngredient{} = owned_ingredient) do
    Repo.delete(owned_ingredient)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking owned_ingredient changes.

  ## Examples

      iex> change_owned_ingredient(owned_ingredient)
      %Ecto.Changeset{data: %OwnedIngredient{}}

  """
  def change_owned_ingredient(%OwnedIngredient{} = owned_ingredient, attrs \\ %{}) do
    OwnedIngredient.changeset(owned_ingredient, attrs)
  end
end
