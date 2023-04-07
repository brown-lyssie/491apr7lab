defmodule StoreManager.Repo.Migrations.CreateStores do
  use Ecto.Migration

  def change do
    create table(:stores) do
      add :name, :string
      add :company_id, references(:companies, on_delete: :nothing)

      timestamps()
    end

    create index(:stores, [:company_id])
  end
end
