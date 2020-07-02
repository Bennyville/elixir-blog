defmodule BlogWeb.PageController do
  use BlogWeb, :controller

  import Ecto.Query

  alias Blog.Posts.Post

  def index(conn, _params) do
    posts = Blog.Repo.all(from p in Post,
      limit: 5,
      order_by: [desc: :inserted_at],
      preload: [:user])

    render(conn, "index.html", posts: posts)
  end
end
