defmodule StoreManager.Business.Clerk do
  use Ecto.Schema
  import Ecto.Changeset

  alias StoreManager.Business.Store

  schema "clerks" do
    field :last_name, :string
    # field :store_id, :id
    belongs_to :store, Store

    timestamps()
  end

  @doc false
  def changeset(clerk, attrs) do
    clerk
    |> cast(attrs, [:last_name])
    |> validate_required([:last_name])
  end
end
