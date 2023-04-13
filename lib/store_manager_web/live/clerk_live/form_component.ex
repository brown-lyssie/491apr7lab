defmodule StoreManagerWeb.ClerkLive.FormComponent do
  use StoreManagerWeb, :live_component

  alias StoreManager.Business

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage clerk records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="clerk-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:last_name]} type="text" label="Last name" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Clerk</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{clerk: clerk} = assigns, socket) do
    changeset = Business.change_clerk(clerk)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"clerk" => clerk_params}, socket) do
    changeset =
      socket.assigns.clerk
      |> Business.change_clerk(clerk_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"clerk" => clerk_params}, socket) do
    save_clerk(socket, socket.assigns.action, clerk_params)
  end

  defp save_clerk(socket, :edit, clerk_params) do
    case Business.update_clerk(socket.assigns.clerk, clerk_params) do
      {:ok, clerk} ->
        notify_parent({:saved, clerk})

        {:noreply,
         socket
         |> put_flash(:info, "Clerk updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_clerk(socket, :new, clerk_params) do
    case Business.create_clerk(clerk_params) do
      {:ok, clerk} ->
        notify_parent({:saved, clerk})

        {:noreply,
         socket
         |> put_flash(:info, "Clerk created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
