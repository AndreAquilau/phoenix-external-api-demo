defmodule SuperAppWeb.TestController do
  use SuperAppWeb, :controller

  def show(conn, %{ "cep" => cep } = params) do

    IO.inspect(params, label: "Params")

    client = Tesla.client([Tesla.Middleware.PathParams, Tesla.Middleware.Logger])

    # Example external API call
    {:ok, %{ body: body} } = Tesla.get(client, "https://viacep.com.br/ws/#{cep}/json/")

    jsonDecode = Jason.decode!(body)

    conn
    |> put_status(:ok)
    |> json(%{cep: jsonDecode})
  end

  def show(conn, _params) do
    conn
    |> put_status(:not_found)
    |> put_view(SuperAppWeb.TemplateHTML)
    |> render("not_found.html")
  end
end
