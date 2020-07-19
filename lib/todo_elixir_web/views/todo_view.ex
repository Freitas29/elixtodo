defmodule TodoElixirWeb.TodoView do
  use TodoElixirWeb, :view
  alias TodoElixirWeb.TodoView

  def render("index.json", %{todos: todos}) do
    %{data: render_many(todos, TodoView, "todo.json")}
  end

  def render("show.json", %{todo: todo}) do
    %{data: render_one(todo, TodoView, "todo.json")}
  end

  def render("todo.json", %{todo: todo}) do
    %{id: todo.id,
      name: todo.name,
      finished: todo.finished}
  end

  def render("error.json", %{project: project}) do
    %{
      message: "Você não tem permissão para alterar o projeto #{project}"
    }
  end
end
