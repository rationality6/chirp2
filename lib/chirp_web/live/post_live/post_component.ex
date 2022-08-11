defmodule ChirpWeb.PostLive.PostComponent do
  use ChirpWeb, :live_component

  def render(assigns) do
    ~H"""
    <div id={"post-#{@post.id}"} class="p-2 m-2 border rounded">

      <div class="flex m-1">
        <img class="object-cover w-20 h-20 rounded" src={Routes.static_path(@socket, "/images/face_icon.png")} />
        <div class="ml-2 flex flex-col justify-center">
          <b>@<%= @post.username %></b>
          <%= @post.body %>
        </div>
      </div>

      <div class="flex justify-between mx-6">
        <a href="#" phx-click="like" phx-target={@myself}>
          <i class="far fa-heart"></i> <%= @post.likes_count %>
        </a>

        <a href="#" phx-click="dislike" phx-target={@myself}>
          <i class="fa-solid fa-heart-crack"></i> <%= @post.dislikes_count %>
        </a>

        <a href="#" phx-click="repost" phx-target={@myself}>
        <i class="far fa-hand-peace"></i> <%= @post.reposts_count %>
        </a>

        <div class="column post-button-column">

          <%= live_patch to: Routes.post_index_path(@socket, :edit, @post.id) do %>
            <i class="far fa-edit"></i>
          <% end %>

          <a href="#" phx-click="delete_post" phx-target={@myself}>
            <i class="far fa-trash-alt"></i>
          </a>

        </div>
      </div>
    </div>
    """
  end

  def handle_event("like", _, socket) do
    Chirp.Timeline.inc_likes(socket.assigns.post)
    {:noreply, socket}
  end

  def handle_event("dislike", _, socket) do
    Chirp.Timeline.inc_dislikes(socket.assigns.post)
    {:noreply, socket}
  end

  def handle_event("repost", _, socket) do
    Chirp.Timeline.inc_reposts(socket.assigns.post)
    {:noreply, socket}
  end

  def handle_event("delete_post", _, socket) do
    Chirp.Timeline.delete_post(socket.assigns.post)
    {:noreply, socket}
  end
end
