defmodule BlogAppWeb.PostController do
  use BlogAppWeb, :controller

  alias BlogApp.Pms
  alias BlogApp.Repo
  alias BlogApp.Pms.Comment
  alias BlogApp.Pms.Post

  def index(conn, _params) do
    posts = Pms.list_posts()
    render(conn, :index, posts: posts)
  end

  def new(conn, _params) do
    changeset = Pms.change_post(%Post{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"post" => post_params}) do
    case Pms.create_post(post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: ~p"/posts/#{post}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    post =
      id
      |> Pms.get_post!()
      |> Repo.preload([:comments])

    changeset = Pms.Comment.changeset(%Comment{}, %{})

    render(conn, :show, post: post, changeset: changeset)
  end

  def edit(conn, %{"id" => id}) do
    post = Pms.get_post!(id)
    changeset = Pms.change_post(post)
    render(conn, :edit, post: post, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Pms.get_post!(id)

    case Pms.update_post(post, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: ~p"/posts/#{post}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Pms.get_post!(id)
    {:ok, _post} = Pms.delete_post(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: ~p"/posts")
  end

  def add_comment(coon, %{"comment" => comment_params, "post_id" => post_id}) do
    post =
      post_id
      |> Pms.get_post!()
      |> Repo.preload([:comments])

    case Pms.add_comment(post_id, comment_params) do
      {:ok, _comment_} ->
        coon
        |> put_flash(:info, "Added comment!")
        |> redirect(to: ~p"/posts/#{post}")

      {:error, _error_} ->
        coon
        |> put_flash(:error, "Oops! Couldn't add comment!")
        |> redirect(to: ~p"/posts/#{post}")
    end
  end

  def get_comments_count(post_id) do
    Pms.get_number_of_comments(post_id)
  end
end
