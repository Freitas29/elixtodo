defmodule TodoElixir.Repo.Migrations.CreateTodos do
  use Ecto.Migration

  def change do
    create table(:todos) do
      add :name, :string
      add :finished, :boolean, default: false, null: false
      add :project_id, references(:projects, on_delete: :nothing)

      timestamps()
    end

    create index(:todos, [:project_id])
  end
end
