defmodule StoreManagerWeb.StoreLive.Index do
  use StoreManagerWeb, :live_view

  alias StoreManager.Business
  alias StoreManager.Repo
  alias StoreManager.Business.Store

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :stores, Business.list_stores())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end <

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Store")
    |> assign(:store, Business.get_store!(id))
    |> assign(:companies, Business.list_companies())

  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Store")
    |> assign(:store, %Store{})
    |> assign(:companies, Business.list_companies())
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Stores")
    |> assign(:store, nil)
  end

  @impl true
  def handle_info({StoreManagerWeb.StoreLive.FormComponent, {:saved, store}}, socket) do
    IO.inspect(store, label: "IN HANDLE INFO")
    {:noreply, stream_insert(socket, :stores, store |> Repo.preload(:company, force: true))}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    store = Business.get_store!(id)
    {:ok, _} = Business.delete_store(store)

    {:noreply, stream_delete(socket, :stores, store)}
  end
end
