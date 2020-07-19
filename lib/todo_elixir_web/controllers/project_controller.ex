defmodule TodoElixirWeb.ProjectController do
  use TodoElixirWeb, :controller

  alias TodoElixir.Projects
  alias TodoElixir.Projects.Project
  alias TodoElixir.Guardian


  action_fallback TodoElixirWeb.FallbackController

  def index(conn, project_params \\ {}) do
    user = Guardian.Plug.current_resource(conn)

    projects = Projects.list_projects(user.id)
    
    render(conn, "index.json", projects: projects)
  end


  def create(conn, %{"project" => project_params}) do
    user = Guardian.Plug.current_resource(conn)
    with {:ok, %Project{} = project} <- Projects.create_project(project_params, user) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.project_path(conn, :show, project))
      |> render("show_one.json", project: project)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Guardian.Plug.current_resource(conn)
    project = Projects.get_project!(id, user.id)
    render(conn, "show.json", project: project)
  end

  def update(conn, %{"id" => id, "project" => project_params}) do
    project = Projects.get_project!(id)

    with {:ok, %Project{} = project} <- Projects.update_project(project, project_params) do
      render(conn, "show.json", project: project)
    end
  end

  def delete(conn, %{"id" => id}) do
    project = Projects.get_project!(id)

    with {:ok, %Project{}} <- Projects.delete_project(project) do
      send_resp(conn, :no_content, "")
    end
  end
end
