defmodule TodoElixir.Projects.Project do
  use Ecto.Schema
  import Ecto.Changeset

  schema "projects" do
    field :title, :string
    field :user_id, :id
    has_many :todos, TodoElixir.Todos.Todo

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
