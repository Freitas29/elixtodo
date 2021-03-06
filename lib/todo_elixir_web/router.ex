defmodule TodoElixirWeb.Router do
  use TodoElixirWeb, :router
  alias TodoElixir.Guardian

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :jwt_authenticated do
    plug Guardian.AuthPipeline
  end

  scope "/api", TodoElixirWeb do
    pipe_through :api
    
    resources "/users", UserController
    post "/sign_in", UserController, :sign_in
  end

  scope "/api", TodoElixirWeb do
    pipe_through [:api, :jwt_authenticated]

    resources "/projects", ProjectController
    resources "/todos", TodoController
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: TodoElixirWeb.Telemetry
    end
  end
end
