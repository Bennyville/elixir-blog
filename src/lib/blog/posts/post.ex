defmodule Blog.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :text, :string
    field :title, :string

    timestamps()

    has_many :comments, Blog.Posts.Comment
    belongs_to :user, Blog.Accounts.User
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:user_id, :title, :text])
    |> validate_required([:user_id, :title, :text])
  end
end
