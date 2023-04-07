defmodule StoreManager.Business.Store do
  use Ecto.Schema
  import Ecto.Changeset

  alias StoreManager.Business.Company

  schema "stores" do
    field :name, :string
    belongs_to :company, Company

    timestamps()
  end

  @doc false
  def changeset(store, attrs) do
    store
    |> cast(attrs, [:name, :company_id])
    |> validate_required([:name, :company_id])
  end
end
