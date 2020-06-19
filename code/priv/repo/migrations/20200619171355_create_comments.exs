defmodule Blog.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :post_id, :integer
      add :author, :string
      add :text, :text

      timestamps()
    end

  end
end
