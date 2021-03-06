defmodule TodoElixirWeb.TodoController do
  use TodoElixirWeb, :controller

  alias TodoElixir.Todos
  alias TodoElixir.Todos.Todo

  action_fallback TodoElixirWeb.FallbackController

  def index(conn, %{"todo" => todo_params}) do
    todos = Todos.list_todos(todo_params)
    render(conn, "index.json", todos: todos)
  end

  def create(conn, %{"todo" => todo_params}) do
    user = Guardian.Plug.current_resource(conn)
    with {:ok, %Todo{} = todo} <- Todos.create_todo(todo_params, user) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.todo_path(conn, :show, todo))
      |> render("show.json", todo: todo)
    else
      {:error, project} -> 
      conn 
      |> put_status(401)
      |> render("error.json", project: project)
    end
  end

  def show(conn, %{"id" => id}) do
    todo = Todos.get_todo!(id)
    render(conn, "show.json", todo: todo)
  end

  def update(conn, %{"id" => id, "todo" => todo_params}) do
    todo = Todos.get_todo!(id)
    user = Guardian.Plug.current_resource(conn)

    with {:ok, %Todo{} = todo} <- Todos.update_todo(todo, todo_params, user) do
      render(conn, "show.json", todo: todo)
    else
      {:error, project} ->
        IO.puts "caiu no error update"
        conn 
        |> put_status(401)
        |> render("error.json", project: project)
    end
  end

  def delete(conn, %{"id" => id}) do
    todo = Todos.get_todo!(id)
    user = Guardian.Plug.current_resource(conn)

    with {:ok, %Todo{}} <- Todos.delete_todo(todo, user) do
      send_resp(conn, :no_content, "")
    end
  end
end
