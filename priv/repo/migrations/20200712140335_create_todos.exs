defmodule TodoElixir.Repo.Migrations.CreateTodos do
  use Ecto.Migration

  def change do
    create table(:todos, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :finished, :boolean, default: false, null: false
      add :project_id, references(:projects, type: :uuid, column: :id, on_delete: :nothing)

      timestamps()
    end

    create index(:todos, [:project_id])
  end
end
