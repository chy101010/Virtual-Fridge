defmodule CookingApp.DislikesTest do
  use CookingApp.DataCase

  alias CookingApp.Dislikes

  describe "dislikes" do
    alias CookingApp.Dislikes.Dislike

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def dislike_fixture(attrs \\ %{}) do
      {:ok, dislike} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Dislikes.create_dislike()

      dislike
    end

    test "list_dislikes/0 returns all dislikes" do
      dislike = dislike_fixture()
      assert Dislikes.list_dislikes() == [dislike]
    end

    test "get_dislike!/1 returns the dislike with given id" do
      dislike = dislike_fixture()
      assert Dislikes.get_dislike!(dislike.id) == dislike
    end

    test "create_dislike/1 with valid data creates a dislike" do
      assert {:ok, %Dislike{} = dislike} = Dislikes.create_dislike(@valid_attrs)
    end

    test "create_dislike/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Dislikes.create_dislike(@invalid_attrs)
    end

    test "update_dislike/2 with valid data updates the dislike" do
      dislike = dislike_fixture()
      assert {:ok, %Dislike{} = dislike} = Dislikes.update_dislike(dislike, @update_attrs)
    end

    test "update_dislike/2 with invalid data returns error changeset" do
      dislike = dislike_fixture()
      assert {:error, %Ecto.Changeset{}} = Dislikes.update_dislike(dislike, @invalid_attrs)
      assert dislike == Dislikes.get_dislike!(dislike.id)
    end

    test "delete_dislike/1 deletes the dislike" do
      dislike = dislike_fixture()
      assert {:ok, %Dislike{}} = Dislikes.delete_dislike(dislike)
      assert_raise Ecto.NoResultsError, fn -> Dislikes.get_dislike!(dislike.id) end
    end

    test "change_dislike/1 returns a dislike changeset" do
      dislike = dislike_fixture()
      assert %Ecto.Changeset{} = Dislikes.change_dislike(dislike)
    end
  end
end
