defmodule TodoElixirWeb.UserView do
  use TodoElixirWeb, :view
  alias TodoElixirWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{jwt: token,user: user}) do
    %{name: user.name,
      email: user.email,
      token: token}
  end

  def render("jwt.json", %{jwt: token}) do
    %{
      token: token
    }
  end
end
