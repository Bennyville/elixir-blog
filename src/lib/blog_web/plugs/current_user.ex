defmodule BlogWeb.Plugs.CurrentUser do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    if current_user = get_session(conn, :current_user) do
      assign(conn, :current_user, current_user)
    else
      conn
    end
  end
end
