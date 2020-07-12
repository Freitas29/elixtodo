defmodule TodoElixirWeb.UserView do
  use TodoElixirWeb, :view
  alias TodoElixirWeb.UserView

  def render("index.json", %{userr: userr}) do
    %{data: render_many(userr, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      name: user.name,
      email: user.email,
      password_hash: user.password_hash}
  end
end