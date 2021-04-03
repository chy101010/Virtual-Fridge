defmodule CookingAppWeb.OwnedIngredientControllerTest do
  use CookingAppWeb.ConnCase

  alias CookingApp.OwnedIngredients
  alias CookingApp.OwnedIngredients.OwnedIngredient

  @create_attrs %{

  }
  @update_attrs %{

  }
  @invalid_attrs %{}

  def fixture(:owned_ingredient) do
    {:ok, owned_ingredient} = OwnedIngredients.create_owned_ingredient(@create_attrs)
    owned_ingredient
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all ownedingredients", %{conn: conn} do
      conn = get(conn, Routes.owned_ingredient_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create owned_ingredient" do
    test "renders owned_ingredient when data is valid", %{conn: conn} do
      conn = post(conn, Routes.owned_ingredient_path(conn, :create), owned_ingredient: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.owned_ingredient_path(conn, :show, id))

      assert %{
               "id" => id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.owned_ingredient_path(conn, :create), owned_ingredient: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update owned_ingredient" do
    setup [:create_owned_ingredient]

    test "renders owned_ingredient when data is valid", %{conn: conn, owned_ingredient: %OwnedIngredient{id: id} = owned_ingredient} do
      conn = put(conn, Routes.owned_ingredient_path(conn, :update, owned_ingredient), owned_ingredient: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.owned_ingredient_path(conn, :show, id))

      assert %{
               "id" => id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, owned_ingredient: owned_ingredient} do
      conn = put(conn, Routes.owned_ingredient_path(conn, :update, owned_ingredient), owned_ingredient: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete owned_ingredient" do
    setup [:create_owned_ingredient]

    test "deletes chosen owned_ingredient", %{conn: conn, owned_ingredient: owned_ingredient} do
      conn = delete(conn, Routes.owned_ingredient_path(conn, :delete, owned_ingredient))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.owned_ingredient_path(conn, :show, owned_ingredient))
      end
    end
  end

  defp create_owned_ingredient(_) do
    owned_ingredient = fixture(:owned_ingredient)
    %{owned_ingredient: owned_ingredient}
  end
end
