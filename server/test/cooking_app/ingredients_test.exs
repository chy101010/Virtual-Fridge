defmodule CookingApp.IngredientsTest do
  use CookingApp.DataCase

  alias CookingApp.Ingredients

  describe "ingredients" do
    alias CookingApp.Ingredients.Ingredient

    @valid_attrs %{ingredient_name: "some ingredient_name"}
    @update_attrs %{ingredient_name: "some updated ingredient_name"}
    @invalid_attrs %{ingredient_name: nil}

    def ingredient_fixture(attrs \\ %{}) do
      {:ok, ingredient} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Ingredients.create_ingredient()

      ingredient
    end

    test "list_ingredients/0 returns all ingredients" do
      ingredient = ingredient_fixture()
      assert Ingredients.list_ingredients() == [ingredient]
    end

    test "get_ingredient!/1 returns the ingredient with given id" do
      ingredient = ingredient_fixture()
      assert Ingredients.get_ingredient!(ingredient.id) == ingredient
    end

    test "create_ingredient/1 with valid data creates a ingredient" do
      assert {:ok, %Ingredient{} = ingredient} = Ingredients.create_ingredient(@valid_attrs)
      assert ingredient.ingredient_name == "some ingredient_name"
    end

    test "create_ingredient/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ingredients.create_ingredient(@invalid_attrs)
    end

    test "update_ingredient/2 with valid data updates the ingredient" do
      ingredient = ingredient_fixture()
      assert {:ok, %Ingredient{} = ingredient} = Ingredients.update_ingredient(ingredient, @update_attrs)
      assert ingredient.ingredient_name == "some updated ingredient_name"
    end

    test "update_ingredient/2 with invalid data returns error changeset" do
      ingredient = ingredient_fixture()
      assert {:error, %Ecto.Changeset{}} = Ingredients.update_ingredient(ingredient, @invalid_attrs)
      assert ingredient == Ingredients.get_ingredient!(ingredient.id)
    end

    test "delete_ingredient/1 deletes the ingredient" do
      ingredient = ingredient_fixture()
      assert {:ok, %Ingredient{}} = Ingredients.delete_ingredient(ingredient)
      assert_raise Ecto.NoResultsError, fn -> Ingredients.get_ingredient!(ingredient.id) end
    end

    test "change_ingredient/1 returns a ingredient changeset" do
      ingredient = ingredient_fixture()
      assert %Ecto.Changeset{} = Ingredients.change_ingredient(ingredient)
    end
  end
end
