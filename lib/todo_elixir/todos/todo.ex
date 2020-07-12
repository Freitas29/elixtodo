defmodule TodoElixir.Todos.Todo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "todos" do
    field :finished, :boolean, default: false
    field :name, :string
    field :project_id, :id

    timestamps()
  end

  @doc false
  def changeset(todo, attrs) do
    todo
    |> cast(attrs, [:name, :finished])
    |> validate_required([:name, :finished, :project_id])
  end
end
