defmodule Discuss.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Discuss.Repo

  alias Discuss.Accounts.User

  def create_or_update_user(user_params) do
    case Repo.get_by(User, email: user_params.email) do
      nil ->
        create_user(user_params)

      user ->
        {:ok, user}
    end
  end

  def create_user(params \\ %{}) do
    %User{}
    |> User.changeset(params)
    |> Repo.insert()
  end

  def get_user!(id) do
    Repo.get!(User, id)
  end

end
