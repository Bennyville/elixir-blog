defmodule Blog.Repo.Migrations.AddUserReferenceToPostsTable do
  use Ecto.Migration

  def change do
    create index(:posts, [:user_id])
  end
end
