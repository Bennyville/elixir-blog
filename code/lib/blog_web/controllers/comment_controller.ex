defmodule BlogWeb.CommentController do
  use BlogWeb, :controller

  alias Blog.Posts
  alias Blog.Posts.Comment

  def index(conn, _params) do
    comments = Posts.list_comments()
    render(conn, "index.html", comments: comments)
  end

  def new(conn, _params) do
    changeset = Posts.change_comment(%Comment{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"comment" => comment_params, "post_id" => post_id}) do
    post = Posts.get_post!(post_id) |> Blog.Repo.preload :comments
    changeset = post
      |> Ecto.build_assoc(:comments)
      |> Comment.changeset(comment_params)

    case Blog.Repo.insert(changeset) do
      {:ok, _comment} ->
        conn
        |> put_flash(:info, "Comment created successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post_id))

      {:error, changeset} ->
        render(conn, BlogWeb.PostView, "new.html", post: post_id, comment_changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    comment = Posts.get_comment!(id)
    render(conn, "show.html", comment: comment)
  end

  def edit(conn, %{"id" => id}) do
    comment = Posts.get_comment!(id)
    changeset = Posts.change_comment(comment)
    render(conn, "edit.html", comment: comment, changeset: changeset)
  end

  def update(conn, %{"id" => id, "comment" => comment_params}) do
    comment = Posts.get_comment!(id)

    case Posts.update_comment(comment, comment_params) do
      {:ok, comment} ->
        conn
        |> put_flash(:info, "Comment updated successfully.")
        |> redirect(to: Routes.comment_path(conn, :show, comment))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", comment: comment, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    comment = Posts.get_comment!(id)
    {:ok, _comment} = Posts.delete_comment(comment)

    conn
    |> put_flash(:info, "Comment deleted successfully.")
    |> redirect(to: Routes.comment_path(conn, :index))
  end
end
