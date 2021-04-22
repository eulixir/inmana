defmodule Inmana.Supplies.Scheduler do
  use GenServer

  alias Inmana.Supplies.ExpirationNotification

  def start_link(_state) do
    GenServer.start_link(__MODULE__, %{})
  end

  @impl true
  def init(state \\ %{}) do
    schedule_notification()
    {:ok, state}
  end

  @impl true
  def handle_info(:generate, state) do
    ExpirationNotification.send()

    schedule_notification()

    {:noreply, state}
  end

  defp schedule_notification do
    Process.send_after(self(), :generate, 1000 * 10)
  end
  # Process.send_after(self(), :generate, 1000 * 10 * 60 * 60 * 24 * 7) to send emails every weeak
end
