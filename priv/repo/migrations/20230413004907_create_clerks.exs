defmodule StoreManager.Repo.Migrations.CreateClerks do
  use Ecto.Migration

  def change do
    create table(:clerks) do
      add :last_name, :string
      add :store_id, references(:stores, on_delete: :nothing)

      timestamps()
    end

    create index(:clerks, [:store_id])
  end
end
