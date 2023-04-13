defmodule StoreManagerWeb.ClerkLive.Index do
  use StoreManagerWeb, :live_view

  alias StoreManager.Business
  alias StoreManager.Business.Clerk

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :clerks, Business.list_clerks())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Clerk")
    |> assign(:clerk, Business.get_clerk!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Clerk")
    |> assign(:clerk, %Clerk{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Clerks")
    |> assign(:clerk, nil)
  end

  @impl true
  def handle_info({StoreManagerWeb.ClerkLive.FormComponent, {:saved, clerk}}, socket) do
    {:noreply, stream_insert(socket, :clerks, clerk)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    clerk = Business.get_clerk!(id)
    {:ok, _} = Business.delete_clerk(clerk)

    {:noreply, stream_delete(socket, :clerks, clerk)}
  end
end
