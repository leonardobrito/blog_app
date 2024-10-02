defmodule BlogApp.PmsTest do
  use BlogApp.DataCase

  alias BlogApp.Pms

  describe "posts" do
    alias BlogApp.Pms.Post

    import BlogApp.PmsFixtures

    @invalid_attrs %{title: nil, body: nil}

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Pms.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Pms.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      valid_attrs = %{title: "some title", body: "some body"}

      assert {:ok, %Post{} = post} = Pms.create_post(valid_attrs)
      assert post.title == "some title"
      assert post.body == "some body"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pms.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      update_attrs = %{title: "some updated title", body: "some updated body"}

      assert {:ok, %Post{} = post} = Pms.update_post(post, update_attrs)
      assert post.title == "some updated title"
      assert post.body == "some updated body"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Pms.update_post(post, @invalid_attrs)
      assert post == Pms.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Pms.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Pms.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Pms.change_post(post)
    end
  end

  describe "comments" do
    alias BlogApp.Pms.Comment

    import BlogApp.PmsFixtures

    @invalid_attrs %{name: nil, content: nil}

    test "list_comments/0 returns all comments" do
      comment = comment_fixture()
      assert Pms.list_comments() == [comment]
    end

    test "get_comment!/1 returns the comment with given id" do
      comment = comment_fixture()
      assert Pms.get_comment!(comment.id) == comment
    end

    test "create_comment/1 with valid data creates a comment" do
      valid_attrs = %{name: "some name", content: "some content"}

      assert {:ok, %Comment{} = comment} = Pms.create_comment(valid_attrs)
      assert comment.name == "some name"
      assert comment.content == "some content"
    end

    test "create_comment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pms.create_comment(@invalid_attrs)
    end

    test "update_comment/2 with valid data updates the comment" do
      comment = comment_fixture()
      update_attrs = %{name: "some updated name", content: "some updated content"}

      assert {:ok, %Comment{} = comment} = Pms.update_comment(comment, update_attrs)
      assert comment.name == "some updated name"
      assert comment.content == "some updated content"
    end

    test "update_comment/2 with invalid data returns error changeset" do
      comment = comment_fixture()
      assert {:error, %Ecto.Changeset{}} = Pms.update_comment(comment, @invalid_attrs)
      assert comment == Pms.get_comment!(comment.id)
    end

    test "delete_comment/1 deletes the comment" do
      comment = comment_fixture()
      assert {:ok, %Comment{}} = Pms.delete_comment(comment)
      assert_raise Ecto.NoResultsError, fn -> Pms.get_comment!(comment.id) end
    end

    test "change_comment/1 returns a comment changeset" do
      comment = comment_fixture()
      assert %Ecto.Changeset{} = Pms.change_comment(comment)
    end
  end
end
