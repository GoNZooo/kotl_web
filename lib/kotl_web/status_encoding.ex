defmodule KOTLWeb.StatusEncoding do
  defimpl Poison.Encoder, for: KOTL.Status do
    def encode(status, opts) do
      %{kind: status.type,
        name: status.name,
        status: status.status} |> Poison.Encoder.encode(opts)
    end
  end
end
