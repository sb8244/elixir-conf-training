defmodule Example2.Mock.ActivityCreator do
  alias Example2.Activity

  def create_random_activity() do
    verb = random_verb()

    %{
      customer_tier: Enum.random(["A", "B", "C", "D"]),
      occurred_at: DateTime.utc_now(),
      what: [random_name(), verb, random_noun()] |> Enum.join(" "),
      what_type: verb,
      who_id: :random.uniform(100_000_000)
    }
    |> Activity.create()
  end

  defp random_name() do
    Enum.random(["Sarah", "Steve", "Ben", "Katie", "Erica", "Grant", "Jacob"])
  end

  defp random_verb() do
    Enum.random(["edited", "viewed", "deleted"])
  end

  defp random_noun() do
    Enum.random(["an email", "a person", "a company"])
  end
end
