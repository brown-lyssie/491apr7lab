defmodule StoreManagerWeb.ClerkLiveTest do
  use StoreManagerWeb.ConnCase

  import Phoenix.LiveViewTest
  import StoreManager.BusinessFixtures

  @create_attrs %{last_name: "some last_name"}
  @update_attrs %{last_name: "some updated last_name"}
  @invalid_attrs %{last_name: nil}

  defp create_clerk(_) do
    clerk = clerk_fixture()
    %{clerk: clerk}
  end

  describe "Index" do
    setup [:create_clerk]

    test "lists all clerks", %{conn: conn, clerk: clerk} do
      {:ok, _index_live, html} = live(conn, ~p"/clerks")

      assert html =~ "Listing Clerks"
      assert html =~ clerk.last_name
    end

    test "saves new clerk", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/clerks")

      assert index_live |> element("a", "New Clerk") |> render_click() =~
               "New Clerk"

      assert_patch(index_live, ~p"/clerks/new")

      assert index_live
             |> form("#clerk-form", clerk: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#clerk-form", clerk: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/clerks")

      html = render(index_live)
      assert html =~ "Clerk created successfully"
      assert html =~ "some last_name"
    end

    test "updates clerk in listing", %{conn: conn, clerk: clerk} do
      {:ok, index_live, _html} = live(conn, ~p"/clerks")

      assert index_live |> element("#clerks-#{clerk.id} a", "Edit") |> render_click() =~
               "Edit Clerk"

      assert_patch(index_live, ~p"/clerks/#{clerk}/edit")

      assert index_live
             |> form("#clerk-form", clerk: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#clerk-form", clerk: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/clerks")

      html = render(index_live)
      assert html =~ "Clerk updated successfully"
      assert html =~ "some updated last_name"
    end

    test "deletes clerk in listing", %{conn: conn, clerk: clerk} do
      {:ok, index_live, _html} = live(conn, ~p"/clerks")

      assert index_live |> element("#clerks-#{clerk.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#clerks-#{clerk.id}")
    end
  end

  describe "Show" do
    setup [:create_clerk]

    test "displays clerk", %{conn: conn, clerk: clerk} do
      {:ok, _show_live, html} = live(conn, ~p"/clerks/#{clerk}")

      assert html =~ "Show Clerk"
      assert html =~ clerk.last_name
    end

    test "updates clerk within modal", %{conn: conn, clerk: clerk} do
      {:ok, show_live, _html} = live(conn, ~p"/clerks/#{clerk}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Clerk"

      assert_patch(show_live, ~p"/clerks/#{clerk}/show/edit")

      assert show_live
             |> form("#clerk-form", clerk: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#clerk-form", clerk: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/clerks/#{clerk}")

      html = render(show_live)
      assert html =~ "Clerk updated successfully"
      assert html =~ "some updated last_name"
    end
  end
end
