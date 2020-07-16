defmodule TodoElixir.Repo.Migrations.CreateProjects do
  use Ecto.Migration

  def change do
    create table(:projects, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :title, :string
      add :user_id, references(:users, type: :uuid, column: :id,on_delete: :nothing)

      timestamps()
    end

    create index(:projects, [:user_id])
  end
end
