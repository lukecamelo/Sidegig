defmodule SidegigWeb.PageController do
  use SidegigWeb, :controller
  alias Sidegig.Clothing
  alias Sidegig.Clothing.Item

  def index(conn, _params) do
    changeset = Item.changeset(%Item{})
    render(conn, "index.html", changeset: changeset)
  end
end
