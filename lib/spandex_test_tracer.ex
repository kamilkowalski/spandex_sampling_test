defmodule SpandexTestTracer do
  use Spandex.Tracer, otp_app: :spandex_test

  @impl Spandex.Tracer
  def span_error(error, stacktrace, opts) do
    super(error, stacktrace, opts)
    __MODULE__.update_priority(2)
  end
end
