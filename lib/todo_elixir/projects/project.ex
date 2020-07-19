defmodule TodoElixir.Projects.Project do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias TodoElixir.Projects.Project
  alias TodoElixir.Users.User
  alias TodoElixir.Repo
  import Ecto.Query

  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :id}
 
  schema "projects" do
    field :title, :string
    field :user_id, :binary_id
    has_many :todos, TodoElixir.Todos.Todo

    timestamps()
  end

  def by_user_id(user_id) do
    Project
    |> where([p], p.user_id == ^user_id)
  end

  def user_has_project?(user_id, project_id) do
    Project
    |> where(user_id: ^user_id)
    |> where(id: ^project_id)
    |> Repo.all()
    |> Enum.count() === 1
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:title, :user_id])
    |> validate_required([:title, :user_id])
  end
end
