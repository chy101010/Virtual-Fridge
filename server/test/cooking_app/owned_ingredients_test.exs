defmodule CookingApp.OwnedIngredientsTest do
  use CookingApp.DataCase

  alias CookingApp.OwnedIngredients

  describe "ownedingredients" do
    alias CookingApp.OwnedIngredients.OwnedIngredient

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def owned_ingredient_fixture(attrs \\ %{}) do
      {:ok, owned_ingredient} =
        attrs
        |> Enum.into(@valid_attrs)
        |> OwnedIngredients.create_owned_ingredient()

      owned_ingredient
    end

    test "list_ownedingredients/0 returns all ownedingredients" do
      owned_ingredient = owned_ingredient_fixture()
      assert OwnedIngredients.list_ownedingredients() == [owned_ingredient]
    end

    test "get_owned_ingredient!/1 returns the owned_ingredient with given id" do
      owned_ingredient = owned_ingredient_fixture()
      assert OwnedIngredients.get_owned_ingredient!(owned_ingredient.id) == owned_ingredient
    end

    test "create_owned_ingredient/1 with valid data creates a owned_ingredient" do
      assert {:ok, %OwnedIngredient{} = owned_ingredient} = OwnedIngredients.create_owned_ingredient(@valid_attrs)
    end

    test "create_owned_ingredient/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = OwnedIngredients.create_owned_ingredient(@invalid_attrs)
    end

    test "update_owned_ingredient/2 with valid data updates the owned_ingredient" do
      owned_ingredient = owned_ingredient_fixture()
      assert {:ok, %OwnedIngredient{} = owned_ingredient} = OwnedIngredients.update_owned_ingredient(owned_ingredient, @update_attrs)
    end

    test "update_owned_ingredient/2 with invalid data returns error changeset" do
      owned_ingredient = owned_ingredient_fixture()
      assert {:error, %Ecto.Changeset{}} = OwnedIngredients.update_owned_ingredient(owned_ingredient, @invalid_attrs)
      assert owned_ingredient == OwnedIngredients.get_owned_ingredient!(owned_ingredient.id)
    end

    test "delete_owned_ingredient/1 deletes the owned_ingredient" do
      owned_ingredient = owned_ingredient_fixture()
      assert {:ok, %OwnedIngredient{}} = OwnedIngredients.delete_owned_ingredient(owned_ingredient)
      assert_raise Ecto.NoResultsError, fn -> OwnedIngredients.get_owned_ingredient!(owned_ingredient.id) end
    end

    test "change_owned_ingredient/1 returns a owned_ingredient changeset" do
      owned_ingredient = owned_ingredient_fixture()
      assert %Ecto.Changeset{} = OwnedIngredients.change_owned_ingredient(owned_ingredient)
    end
  end
end
