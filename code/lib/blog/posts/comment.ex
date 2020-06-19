defmodule Blog.Posts.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :author, :string
    field :post_id, :integer
    field :text, :string

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:post_id, :author, :text])
    |> validate_required([:post_id, :author, :text])
  end
end
