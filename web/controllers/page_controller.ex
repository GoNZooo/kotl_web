defmodule KOTLWeb.PageController do
  use KOTLWeb.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
