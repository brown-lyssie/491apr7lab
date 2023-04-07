defmodule StoreManagerWeb.CompanyLive.Index do
  use StoreManagerWeb, :live_view

  alias StoreManager.Business
  alias StoreManager.Business.Company

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :companies, Business.list_companies())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Company")
    |> assign(:company, Business.get_company!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Company")
    |> assign(:company, %Company{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Companies")
    |> assign(:company, nil)
  end

  @impl true
  def handle_info({StoreManagerWeb.CompanyLive.FormComponent, {:saved, company}}, socket) do
    {:noreply, stream_insert(socket, :companies, company)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    company = Business.get_company!(id)
    {:ok, _} = Business.delete_company(company)

    {:noreply, stream_delete(socket, :companies, company)}
  end
end
