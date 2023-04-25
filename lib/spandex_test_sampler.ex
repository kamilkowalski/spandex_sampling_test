defmodule SpandexTestSampler do
  @moduledoc """
  A plug that samples requests based on a rate.
  """

  @behaviour Plug

  @doc """
  Initializes the plug with the given options.
  """
  @spec init(Keyword.t()) :: Keyword.t()
  def init(opts) do
    opts
  end

  @doc """
  Samples requests based on the rate.
  """
  @spec call(Plug.Conn.t(), Keyword.t()) :: Plug.Conn.t()
  def call(conn, opts) do
    rate = Keyword.get(opts, :rate)
    current_priority = SpandexTestTracer.current_priority()
    trace_id = SpandexTestTracer.current_trace_id()

    update_priority(trace_id, current_priority, rate)

    conn
  end

  defp update_priority(trace_id, current_priority, rate)

  # Priority should be set only if:
  # - there is an active trace
  # - there is no priority set already, e.g. decoded from headers
  defp update_priority(trace_id, nil, rate) when not is_nil(trace_id) do
    # There's a bug in SpandexDatadog.Constants so we have to use the values directly
    priority =
      case SpandexDatadog.RateSampler.sampled?(trace_id, rate) do
        # auto-keep
        true -> 1
        # auto-reject
        false -> 0
      end

    SpandexTestTracer.update_priority(priority)
  end

  defp update_priority(_, _, _), do: nil
end
