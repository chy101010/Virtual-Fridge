defmodule CookingAppWeb.DislikeControllerTest do
  use CookingAppWeb.ConnCase

  alias CookingApp.Dislikes
  alias CookingApp.Dislikes.Dislike

  @create_attrs %{

  }
  @update_attrs %{

  }
  @invalid_attrs %{}

  def fixture(:dislike) do
    {:ok, dislike} = Dislikes.create_dislike(@create_attrs)
    dislike
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all dislikes", %{conn: conn} do
      conn = get(conn, Routes.dislike_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create dislike" do
    test "renders dislike when data is valid", %{conn: conn} do
      conn = post(conn, Routes.dislike_path(conn, :create), dislike: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.dislike_path(conn, :show, id))

      assert %{
               "id" => id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.dislike_path(conn, :create), dislike: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update dislike" do
    setup [:create_dislike]

    test "renders dislike when data is valid", %{conn: conn, dislike: %Dislike{id: id} = dislike} do
      conn = put(conn, Routes.dislike_path(conn, :update, dislike), dislike: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.dislike_path(conn, :show, id))

      assert %{
               "id" => id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, dislike: dislike} do
      conn = put(conn, Routes.dislike_path(conn, :update, dislike), dislike: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete dislike" do
    setup [:create_dislike]

    test "deletes chosen dislike", %{conn: conn, dislike: dislike} do
      conn = delete(conn, Routes.dislike_path(conn, :delete, dislike))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.dislike_path(conn, :show, dislike))
      end
    end
  end

  defp create_dislike(_) do
    dislike = fixture(:dislike)
    %{dislike: dislike}
  end
end
