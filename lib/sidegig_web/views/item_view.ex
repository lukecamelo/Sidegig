defmodule SidegigWeb.ItemView do
  use SidegigWeb, :view
  alias SidegigWeb.ItemView

  def render("index.json", %{items: items}) do
    %{data: render_many(items, ItemView, "item.json")}
  end

  def render("show.json", %{item: item}) do
    %{data: render_one(item, ItemView, "item.json")}
  end

  def render("item.json", %{item: item}) do
    %{id: item.id,
      name: item.name,
      price_paid: item.price_paid,
      price_sold: item.price_sold}
      # sold: item.sold}
  end
end
