defmodule SidegigWeb.ItemController do
  use SidegigWeb, :controller

  alias Sidegig.Clothing
  alias Sidegig.Clothing.Item

  action_fallback SidegigWeb.FallbackController

  def index(conn, _params) do
    items = Clothing.list_items()
    render(conn, "index.json", items: items)
  end

  def create(conn, %{"item" => item_params}) do
    with {:ok, %Item{} = item} <- Clothing.create_item(item_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.item_path(conn, :show, item))
      |> render("show.json", item: item)
    end
  end

  def show(conn, %{"id" => id}) do
    item = Clothing.get_item!(id)
    render(conn, "show.json", item: item)
  end

  def update(conn, %{"id" => id, "item" => item_params}) do
    item = Clothing.get_item!(id)

    with {:ok, %Item{} = item} <- Clothing.update_item(item, item_params) do
      render(conn, "show.json", item: item)
    end
  end

  def delete(conn, %{"id" => id}) do
    item = Clothing.get_item!(id)

    with {:ok, %Item{}} <- Clothing.delete_item(item) do
      send_resp(conn, :no_content, "")
    end
  end
end
