defmodule Sidegig.ClothingTest do
  use Sidegig.DataCase

  alias Sidegig.Clothing

  describe "items" do
    alias Sidegig.Clothing.Item

    @valid_attrs %{name: "some name", price_paid: 42, price_sold: 42, sold: true}
    @update_attrs %{name: "some updated name", price_paid: 43, price_sold: 43, sold: false}
    @invalid_attrs %{name: nil, price_paid: nil, price_sold: nil, sold: nil}

    def item_fixture(attrs \\ %{}) do
      {:ok, item} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Clothing.create_item()

      item
    end

    test "list_items/0 returns all items" do
      item = item_fixture()
      assert Clothing.list_items() == [item]
    end

    test "get_item!/1 returns the item with given id" do
      item = item_fixture()
      assert Clothing.get_item!(item.id) == item
    end

    test "create_item/1 with valid data creates a item" do
      assert {:ok, %Item{} = item} = Clothing.create_item(@valid_attrs)
      assert item.name == "some name"
      assert item.price_paid == 42
      assert item.price_sold == 42
      assert item.sold == true
    end

    test "create_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Clothing.create_item(@invalid_attrs)
    end

    test "update_item/2 with valid data updates the item" do
      item = item_fixture()
      assert {:ok, %Item{} = item} = Clothing.update_item(item, @update_attrs)
      assert item.name == "some updated name"
      assert item.price_paid == 43
      assert item.price_sold == 43
      assert item.sold == false
    end

    test "update_item/2 with invalid data returns error changeset" do
      item = item_fixture()
      assert {:error, %Ecto.Changeset{}} = Clothing.update_item(item, @invalid_attrs)
      assert item == Clothing.get_item!(item.id)
    end

    test "delete_item/1 deletes the item" do
      item = item_fixture()
      assert {:ok, %Item{}} = Clothing.delete_item(item)
      assert_raise Ecto.NoResultsError, fn -> Clothing.get_item!(item.id) end
    end

    test "change_item/1 returns a item changeset" do
      item = item_fixture()
      assert %Ecto.Changeset{} = Clothing.change_item(item)
    end
  end
end
