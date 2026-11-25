defmodule Servy.Handler do
  @moduledoc """

  """
  def handler(request) do
    # conv = parse(request)
    # conv = route(conv)
    # format_response(conv)

    # request
    # |> parse()
    # |> route()
    # |> format_response()

    parse(request)
    |> route()
    |> format_response()
  end

  defp parse(request) do
    conv = %{ method: "GET", path: "/wildthings", resp_body: ""}
  end

  defp route(conv) do
    conv = %{method: "GET", path: "/wildthings", resp_body: "Bears, Lions, Tigers"}
  end

  defp format_response(conv) do
    """
      HTTP/1.1 200 OK
      Content-Type:  text/html
      Content-Length: 20

      Bears, Lions, Tigers
    """
  end
end


# request = """
#   GET /wildthings HTTP/1.1
#   Host: example.com
#   User-Agent: ExampleBrowser/1.0
#   Accept: */*

# """



