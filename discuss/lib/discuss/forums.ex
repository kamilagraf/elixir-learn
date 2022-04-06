defmodule Discuss.Forums do
  @moduledoc """
  The Forums context.
  """

  import Ecto.Query, warn: false

  alias Discuss.Repo
  alias Discuss.Forums.Topic
  alias Discuss.Forums.Comment


  def list_topics do
    Repo.all(Topic)
  end

  def change_topic(%Topic{} = topic, params \\ %{}) do
    Topic.changeset(topic, params)
  end

  def create_topic(params \\ %{}, user) do
    user
    |> Ecto.build_assoc(:topics)
    |> Topic.changeset(params)
    |> Repo.insert()
  end

  def get_topic!(id) do
    Repo.get!(Topic, id)
  end

  def get_topic_with_comments!(id) do
    Repo.get!(Topic, id)
    |> Repo.preload(comments: [:user])
  end

  def update_topic(%Topic{} = topic, params) do
    topic
    |> Topic.changeset(params)
    |> Repo.update()
  end

  def delete_topic(%Topic{} = topic) do
    Repo.delete(topic)
  end

  def create_comment(params \\ %{}, topic, user_id) do
    topic
    |> Ecto.build_assoc(:comments, user_id: user_id)
    |> Comment.changeset(params)
    |> Repo.insert()
  end



end
