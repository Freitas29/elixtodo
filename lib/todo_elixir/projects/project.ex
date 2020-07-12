defmodule TodoElixir.Projects.Project do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias TodoElixir.Projects.Project
  import Ecto.Query

  schema "projects" do
    field :title, :string
    field :user_id, :id
    has_many :todos, TodoElixir.Todos.Todo

    timestamps()
  end

  def by_user(user_id) do
    Project
    |> where([p], p.user_id == ^user_id)
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:title])
    |> validate_required([:title, :user_id])
  end
end
