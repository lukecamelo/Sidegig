defmodule Sidegig.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :name, :string
      add :price_paid, :integer
      add :price_sold, :integer
      add :sold, :boolean, default: false, null: false

      timestamps()
    end

  end
end
