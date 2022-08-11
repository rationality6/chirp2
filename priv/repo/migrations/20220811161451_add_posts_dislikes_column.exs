defmodule Chirp.Repo.Migrations.AddPostsDislikesColumn do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :dislikes_count, :integer
    end
  end
end
