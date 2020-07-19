defmodule TodoElixir.Todos do
  @moduledoc """
  The Todos context.
  """

  import Ecto.Query, warn: false
  alias TodoElixir.Repo

  alias TodoElixir.Todos.Todo
  alias TodoElixir.Projects.Project

  @doc """
  Returns the list of todos.

  ## Examples

      iex> list_todos()
      [%Todo{}, ...]

  """
  def list_todos(project_id) do
    query = Todo.by_project_id(project_id)
    
    Repo.all(query)
  end

  @doc """
  Gets a single todo.

  Raises `Ecto.NoResultsError` if the Todo does not exist.

  ## Examples

      iex> get_todo!(123)
      %Todo{}

      iex> get_todo!(456)
      ** (Ecto.NoResultsError)

  """
  def get_todo!(id), do: Repo.get!(Todo, id)

  @doc """
  Creates a todo.

  ## Examples

      iex> create_todo(%{field: value})
      {:ok, %Todo{}}

      iex> create_todo(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_todo(attrs \\ %{}, user) do
    project_id = attrs["project_id"]
    user_id = user.id

    if Project.user_has_project?(user_id, project_id) do
        %Todo{}
        |> Todo.changeset(attrs)
        |> Repo.insert()
    else
      {:error, project_id}
    end

  end

  @doc """
  Updates a todo.

  ## Examples

      iex> update_todo(todo, %{field: new_value})
      {:ok, %Todo{}}

      iex> update_todo(todo, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_todo(%Todo{} = todo, attrs, user) do
    project_id = todo.project_id
    user_id = user.id
    
    if Project.user_has_project?(user_id, project_id) do
      todo
      |> Todo.changeset(attrs)
      |> Repo.update()
    else
      {:error, project_id}
    end
  end

  @doc """
  Deletes a todo.

  ## Examples

      iex> delete_todo(todo)
      {:ok, %Todo{}}

      iex> delete_todo(todo)
      {:error, %Ecto.Changeset{}}

  """
  def delete_todo(%Todo{} = todo, user) do
    project_id = todo["project_id"]
    user_id = user.id
    
    if Project.user_has_project?(user_id, project_id) do
      Repo.delete(todo)
    else
      {:error, project_id}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking todo changes.

  ## Examples

      iex> change_todo(todo)
      %Ecto.Changeset{data: %Todo{}}

  """
  def change_todo(%Todo{} = todo, attrs \\ %{}) do
    Todo.changeset(todo, attrs)
  end
end
