defmodule InakaPongWeb.PageController do
  use InakaPongWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
