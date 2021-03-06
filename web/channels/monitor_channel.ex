defmodule KOTLWeb.MonitorChannel do
  use KOTLWeb.Web, :channel

  defp get_current_statuses do
    KOTL.Monitor.Manager.current_statuses
  end

  def join("monitors:lobby", payload, socket) do
    if authorized?(payload) do
      send self(), :after_join
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_info(:after_join, socket) do
    monitorees = get_current_statuses
    push socket, "set_monitorees", %{monitorees: monitorees}
    Process.send_after(self(), :poll, 10_000)
    {:noreply, socket}
  end

  def handle_info(:poll, socket) do
    monitorees = get_current_statuses
    push socket, "set_monitorees", %{monitorees: monitorees}
    Process.send_after(self(), :poll, 10_000)
    {:noreply, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (monitors:lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  # This is invoked every time a notification is being broadcast
  # to the client. The default implementation is just to push it
  # downstream but one could filter or change the event.
  def handle_out(event, payload, socket) do
    push socket, event, payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
