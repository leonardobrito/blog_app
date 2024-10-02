defmodule BlogApp.Pms.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :name, :string
    field :content, :string
    field :post_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:name, :content, :post_id])
    |> validate_required([:name, :content, :post_id])
  end
end
