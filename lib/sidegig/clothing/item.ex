defmodule Sidegig.Clothing.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :name, :string
    field :price_paid, :integer
    field :price_sold, :integer
    field :sold, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:name, :price_paid, :price_sold, :sold])
    |> validate_required([:name, :price_paid, :price_sold, :sold])
  end
end
