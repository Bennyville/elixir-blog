defmodule Blog.Repo.Migrations.AddReferenceToUserIdRow do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      modify :user_id, references(:users)
    end
  end
end
