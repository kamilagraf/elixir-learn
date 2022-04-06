defmodule DiscussWeb.CommentsChannel do
  use DiscussWeb, :channel

  alias Phoenix.Channel
  alias Discuss.Repo


  @impl true
  def join("comments:" <> topic_id, _params, socket) do
    topic_id = String.to_integer(topic_id)
    topic = Discuss.Forums.get_topic_with_comments!(topic_id)

    {:ok, %{comments: topic.comments}, assign(socket, :topic, topic)}
  end

@impl true
  def handle_in(_name, %{"content" => content}, socket) do
    %{assigns: %{topic: topic, user_id: user_id}} = socket

    case Discuss.Forums.create_comment(%{content: content}, topic, user_id) do
      {:ok, comment} ->
        Channel.broadcast!(socket, "comments:#{socket.assigns.topic.id}:new", %{
          comment: Repo.preload(comment, :user)
        })

        {:reply, :ok, socket}

      {:error, changeset} ->
        {:reply, {:error, %{errors: changeset}}, socket}
    end
  end

  # Add authorization logic here as required.
  # defp authorized?(_payload) do
  #   true
  # end

end
