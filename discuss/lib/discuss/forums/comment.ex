defmodule Discuss.Forums.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:content]}

  schema "comments" do
    field :content, :string
    belongs_to :user, Discuss.Accounts.User
    belongs_to :topic, Discuss.Forums.Topic

    timestamps()
  end

  @doc false
  def changeset(comment, params) do
    comment
    |> cast(params, [:content])
    |> validate_required([:content])
  end
end
