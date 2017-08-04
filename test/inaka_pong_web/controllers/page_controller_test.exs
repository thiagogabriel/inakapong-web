defmodule InakaPongWeb.PageControllerTest do
  use InakaPongWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Scoreboard"
  end
end
