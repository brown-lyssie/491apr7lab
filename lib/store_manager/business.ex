defmodule StoreManager.Business do
  @moduledoc """
  The Business context.
  """

  import Ecto.Query, warn: false
  alias StoreManager.Repo

  alias StoreManager.Business.Company

  @doc """
  Returns the list of companies.

  ## Examples

      iex> list_companies()
      [%Company{}, ...]

  """
  def list_companies do
    Repo.all(Company)
    |> Repo.preload(:stores)
  end

  @doc """
  Gets a single company.

  Raises `Ecto.NoResultsError` if the Company does not exist.

  ## Examples

      iex> get_company!(123)
      %Company{}

      iex> get_company!(456)
      ** (Ecto.NoResultsError)

  """
  def get_company!(id) do
    Repo.get!(Company, id)
    |> Repo.preload(:stores)
  end

  @doc """
  Creates a company.

  ## Examples

      iex> create_company(%{field: value})
      {:ok, %Company{}}

      iex> create_company(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_company(attrs \\ %{}) do
    %Company{}
    |> Company.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a company.

  ## Examples

      iex> update_company(company, %{field: new_value})
      {:ok, %Company{}}

      iex> update_company(company, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_company(%Company{} = company, attrs) do
    company
    |> Company.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a company.

  ## Examples

      iex> delete_company(company)
      {:ok, %Company{}}

      iex> delete_company(company)
      {:error, %Ecto.Changeset{}}

  """
  def delete_company(%Company{} = company) do
    Repo.delete(company)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking company changes.

  ## Examples

      iex> change_company(company)
      %Ecto.Changeset{data: %Company{}}

  """
  def change_company(%Company{} = company, attrs \\ %{}) do
    Company.changeset(company, attrs)
  end

  alias StoreManager.Business.Store

  @doc """
  Returns the list of stores.

  ## Examples

      iex> list_stores()
      [%Store{}, ...]

  """
  def list_stores do
    Store
    |> Repo.all
    |> Repo.preload(:company)
    |> Repo.preload(:clerks)
  end

  @doc """
  Gets a single store.

  Raises `Ecto.NoResultsError` if the Store does not exist.

  ## Examples

      iex> get_store!(123)
      %Store{}

      iex> get_store!(456)
      ** (Ecto.NoResultsError)

  """
  def get_store!(id) do
    Repo.get!(Store, id) |> Repo.preload(:company)
  end

  @doc """
  Creates a store.

  ## Examples

      iex> create_store(%{field: value})
      {:ok, %Store{}}

      iex> create_store(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_store(attrs \\ %{}) do
    %Store{}
    |> Store.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a store.

  ## Examples

      iex> update_store(store, %{field: new_value})
      {:ok, %Store{}}

      iex> update_store(store, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_store(%Store{} = store, attrs) do
    store
    |> Store.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a store.

  ## Examples

      iex> delete_store(store)
      {:ok, %Store{}}

      iex> delete_store(store)
      {:error, %Ecto.Changeset{}}

  """
  def delete_store(%Store{} = store) do
    Repo.delete(store)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking store changes.

  ## Examples

      iex> change_store(store)
      %Ecto.Changeset{data: %Store{}}

  """
  def change_store(%Store{} = store, attrs \\ %{}) do
    Store.changeset(store, attrs)
  end

  alias StoreManager.Business.Clerk

  @doc """
  Returns the list of clerks.

  ## Examples

      iex> list_clerks()
      [%Clerk{}, ...]

  """
  def list_clerks do
    Repo.all(Clerk)
    |> Repo.preload(:store)
  end

  @doc """
  Gets a single clerk.

  Raises `Ecto.NoResultsError` if the Clerk does not exist.

  ## Examples

      iex> get_clerk!(123)
      %Clerk{}

      iex> get_clerk!(456)
      ** (Ecto.NoResultsError)

  """
  def get_clerk!(id), do: Repo.get!(Clerk, id)

  @doc """
  Creates a clerk.

  ## Examples

      iex> create_clerk(%{field: value})
      {:ok, %Clerk{}}

      iex> create_clerk(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_clerk(attrs \\ %{}) do
    %Clerk{}
    |> Clerk.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a clerk.

  ## Examples

      iex> update_clerk(clerk, %{field: new_value})
      {:ok, %Clerk{}}

      iex> update_clerk(clerk, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_clerk(%Clerk{} = clerk, attrs) do
    clerk
    |> Clerk.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a clerk.

  ## Examples

      iex> delete_clerk(clerk)
      {:ok, %Clerk{}}

      iex> delete_clerk(clerk)
      {:error, %Ecto.Changeset{}}

  """
  def delete_clerk(%Clerk{} = clerk) do
    Repo.delete(clerk)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking clerk changes.

  ## Examples

      iex> change_clerk(clerk)
      %Ecto.Changeset{data: %Clerk{}}

  """
  def change_clerk(%Clerk{} = clerk, attrs \\ %{}) do
    Clerk.changeset(clerk, attrs)
  end
end
