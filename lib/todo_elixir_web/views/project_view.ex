defmodule TodoElixirWeb.ProjectView do
  use TodoElixirWeb, :view
  alias TodoElixirWeb.ProjectView
  alias TodoElixirWeb.TodoView

  def render("index.json", %{projects: projects}) do
    %{data: render_many(projects, ProjectView, "project.json")}
  end

  def render("show.json", %{project: project}) do
    %{data: render_one(project, ProjectView, "project.json"),
      todos: render_many(project.todos, TodoView, "todo.json")}
  end

  def render("show_one.json", %{project: project}) do
    %{
      id: project.id,
      title: project.title
    }
  end

  def render("project.json", %{project: project}) do
    %{id: project.id,
      title: project.title}
  end
end
