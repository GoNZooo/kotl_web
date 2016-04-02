ExUnit.start

Mix.Task.run "ecto.create", ~w(-r KOTLWeb.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r KOTLWeb.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(KOTLWeb.Repo)

