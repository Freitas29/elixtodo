defmodule TodoElixir.Guardian.AuthPipeline do
    use Guardian.Plug.Pipeline, otp_app: :todo_elixir,
    module: TodoElixir.Guardian,
    error_handler: TodoElixir.AuthErrorHandler
  
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.EnsureAuthenticated
    plug Guardian.Plug.LoadResource
  end