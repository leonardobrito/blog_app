defmodule BlogApp.PmsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BlogApp.Pms` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        body: "some body",
        title: "some title"
      })
      |> BlogApp.Pms.create_post()

    post
  end

  @doc """
  Generate a comment.
  """
  def comment_fixture(attrs \\ %{}) do
    {:ok, comment} =
      attrs
      |> Enum.into(%{
        content: "some content",
        name: "some name"
      })
      |> BlogApp.Pms.create_comment()

    comment
  end
end
