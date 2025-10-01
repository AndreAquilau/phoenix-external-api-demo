defmodule SuperAppWeb.PageController do
  use SuperAppWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
