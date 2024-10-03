defmodule BlogApp.Features.PostPagesTest do
  use BlogApp.FeatureCase, async: true
  import Query, only: [button: 1, fillable_field: 1, link: 1]
  import BlogApp.PmsFixtures

  @title_field fillable_field("post[title]")
  @body_field fillable_field("post[body]")
  @comment_name_field fillable_field("comment[name]")
  @comment_content_field fillable_field("comment[content]")
  @new_post_button button("New Post")
  @edit_post_button button("Edit post")
  @save_post_button button("Save Post")
  @add_comment_button button("Add comment")
  @back_to_posts_link link("Back to posts")

  test "Visiting the post list page", %{session: session} do
    session = visit(session, "/posts")

    assert_text(session, "Listing Posts")
    assert_has(session, @new_post_button)
  end

  test "Visiting the new post page", %{session: session} do
    session = visit(session, "/posts/new")

    assert_text(session, "New Post")
    assert_has(session, @title_field)
    assert_has(session, @body_field)
    assert_has(session, @back_to_posts_link)
    assert_has(session, @save_post_button)
  end

  test "Creating a new post with valid attrs", %{session: session} do
    session =
      session
      |> visit("/posts/new")
      |> fill_in(@title_field, with: "some title")
      |> fill_in(@body_field, with: "some body")
      |> click(@save_post_button)

    assert session |> has_text?("Post created successfully.")
  end

  describe "/post/:id" do
    setup [:create_post]

    test "Visiting a post page", %{session: session, post: post} do
      session
      |> visit("/posts/#{post.id}")
      |> assert_text(post.title)
      |> assert_text(post.body)
      |> assert_has(@edit_post_button)
      |> assert_text("Comments:")
      |> assert_has(@comment_name_field)
      |> assert_has(@comment_content_field)
      |> assert_has(@add_comment_button)
    end

    test "Creating a post comment with valid attrs", %{session: session, post: post} do
      session
      |> visit("/posts/#{post.id}")
      |> fill_in(@comment_name_field, with: "some comment name")
      |> fill_in(@comment_content_field, with: "some comment content")
      |> click(@add_comment_button)
      |> assert_text("Added comment!")
      |> assert_text("some comment name")
      |> assert_text("some comment content")
    end

    test "Creating a post comment with invalid attrs", %{session: session, post: post} do
      session
      |> visit("/posts/#{post.id}")
      |> click(@add_comment_button)
      |> assert_text("Oops! Couldn't add comment!")
    end
  end

  test "Creating a new post with invalid attrs", %{session: session} do
    session =
      session
      |> visit("/posts/new")
      |> click(@save_post_button)

    assert session |> has_text?("Oops, something went wrong! Please check the errors below.")
    assert session |> has_text?("can't be blank")
  end

  defp create_post(_) do
    post = post_fixture()
    %{post: post}
  end
end
