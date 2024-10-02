defmodule BlogAppWeb.PostHTML do
  use BlogAppWeb, :html

  alias BlogApp.Pms

  embed_templates "post_html/*"

  @doc """
  Renders a post form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def post_form(assigns)

  def get_comments_count(post_id) do
    Pms.get_number_of_comments(post_id)
  end
end
