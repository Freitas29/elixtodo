defmodule TodoElixir.Todos.Todo do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias TodoElixir.Todos.Todo

  schema "todos" do
    field :finished, :boolean, default: false
    field :name, :string
    field :project_id, :id

    timestamps()
  end

  def by_project_id (project_id) do
    Todo
    |> where([t], t.id == ^project_id)
  end

  @doc false
  def changeset(todo, attrs) do
    todo
    |> cast(attrs, [:name, :finished])
    |> validate_required([:name, :finished, :project_id])
  end
end
