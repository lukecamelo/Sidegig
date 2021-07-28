defmodule SidegigWeb.ItemControllerTest do
  use SidegigWeb.ConnCase

  alias Sidegig.Clothing
  alias Sidegig.Clothing.Item

  @create_attrs %{
    name: "some name",
    price_paid: 42,
    price_sold: 42,
    sold: true
  }
  @update_attrs %{
    name: "some updated name",
    price_paid: 43,
    price_sold: 43,
    sold: false
  }
  @invalid_attrs %{name: nil, price_paid: nil, price_sold: nil, sold: nil}

  def fixture(:item) do
    {:ok, item} = Clothing.create_item(@create_attrs)
    item
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all items", %{conn: conn} do
      conn = get(conn, Routes.item_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create item" do
    test "renders item when data is valid", %{conn: conn} do
      conn = post(conn, Routes.item_path(conn, :create), item: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.item_path(conn, :show, id))

      assert %{
               "id" => id,
               "name" => "some name",
               "price_paid" => 42,
               "price_sold" => 42,
               "sold" => true
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.item_path(conn, :create), item: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update item" do
    setup [:create_item]

    test "renders item when data is valid", %{conn: conn, item: %Item{id: id} = item} do
      conn = put(conn, Routes.item_path(conn, :update, item), item: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.item_path(conn, :show, id))

      assert %{
               "id" => id,
               "name" => "some updated name",
               "price_paid" => 43,
               "price_sold" => 43,
               "sold" => false
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, item: item} do
      conn = put(conn, Routes.item_path(conn, :update, item), item: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete item" do
    setup [:create_item]

    test "deletes chosen item", %{conn: conn, item: item} do
      conn = delete(conn, Routes.item_path(conn, :delete, item))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.item_path(conn, :show, item))
      end
    end
  end

  defp create_item(_) do
    item = fixture(:item)
    %{item: item}
  end
end
