defmodule CookingApp.Dislikes do
  @moduledoc """
  The Dislikes context.
  """

  import Ecto.Query, warn: false
  alias CookingApp.Repo

  alias CookingApp.Dislikes.Dislike

  @doc """
  Returns the list of dislikes.

  ## Examples

      iex> list_dislikes()
      [%Dislike{}, ...]

  """
  def list_dislikes do
    Repo.all(Dislike)
  end

  @doc """
  Gets a single dislike.

  Raises `Ecto.NoResultsError` if the Dislike does not exist.

  ## Examples

      iex> get_dislike!(123)
      %Dislike{}

      iex> get_dislike!(456)
      ** (Ecto.NoResultsError)

  """
  def get_dislike!(id), do: Repo.get!(Dislike, id)

  @doc """
  Creates a dislike.

  ## Examples

      iex> create_dislike(%{field: value})
      {:ok, %Dislike{}}

      iex> create_dislike(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_dislike(attrs \\ %{}) do
    %Dislike{}
    |> Dislike.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a dislike.

  ## Examples

      iex> update_dislike(dislike, %{field: new_value})
      {:ok, %Dislike{}}

      iex> update_dislike(dislike, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_dislike(%Dislike{} = dislike, attrs) do
    dislike
    |> Dislike.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a dislike.

  ## Examples

      iex> delete_dislike(dislike)
      {:ok, %Dislike{}}

      iex> delete_dislike(dislike)
      {:error, %Ecto.Changeset{}}

  """
  def delete_dislike(%Dislike{} = dislike) do
    Repo.delete(dislike)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking dislike changes.

  ## Examples

      iex> change_dislike(dislike)
      %Ecto.Changeset{data: %Dislike{}}

  """
  def change_dislike(%Dislike{} = dislike, attrs \\ %{}) do
    Dislike.changeset(dislike, attrs)
  end
end
