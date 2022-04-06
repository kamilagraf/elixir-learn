defmodule Discuss.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

    @derive {Jason.Encoder, only: [:email]}

  schema "users" do
    field :email, :string
    field :provider, :string
    field :token, :string
    has_many :topics, Discuss.Forums.Topic
    has_many :comments, Discuss.Forums.Comment

    timestamps()
  end


  def changeset(user, params \\ %{}) do
    user
    |> cast(params, [:email, :provider, :token])
    |> validate_required([:email, :provider, :token])
  end
end
