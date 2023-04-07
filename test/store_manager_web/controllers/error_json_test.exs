defmodule StoreManagerWeb.ErrorJSONTest do
  use StoreManagerWeb.ConnCase, async: true

  test "renders 404" do
    assert StoreManagerWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert StoreManagerWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
