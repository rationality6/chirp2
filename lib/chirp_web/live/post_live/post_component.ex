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
        <div class="column post-button-column">
          <i class="far fa-heart"></i> <%= @post.likes_count %>
        </div>
        <div class="column post-button-column">
          <i class="far fa-hand-peace"></i> <%= @post.reposts_count %>
        </div>
        <div class="column post-button-column">
          <%= live_patch to: Routes.post_index_path(@socket, :edit, @post.id) do %>
            <i class="far fa-edit"></i>
          <% end %>
          <%= link to: "#", phx_click: "delete", phx_value_id: @post.id do %>
            <i class="far fa-trash-alt"></i>
          <% end %>
        </div>
      </div>
    </div>
    """
  end

  def handle_event("like", _, socket) do
    Chirp.Timeline.inc_likes(socket.assigns.post)
    {:noreply, socket}
  end

  def handle_event("repost", _, socket) do
    Chirp.Timeline.inc_reposts(socket.assigns.post)
    {:noreply, socket}
  end
end
