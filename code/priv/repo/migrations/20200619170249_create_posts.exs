defmodule Blog.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :user_id, :integer
      add :title, :string
      add :text, :text

      timestamps()
    end

  end
end
