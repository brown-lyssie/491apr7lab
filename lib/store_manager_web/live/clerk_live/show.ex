defmodule StoreManagerWeb.ClerkLive.Show do
  use StoreManagerWeb, :live_view

  alias StoreManager.Business

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:clerk, Business.get_clerk!(id))}
  end

  defp page_title(:show), do: "Show Clerk"
  defp page_title(:edit), do: "Edit Clerk"
end
