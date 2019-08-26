defmodule Example2.Activity.ActivityStore do
  import Ecto.Query

  alias Example2.Repo
  alias Example2.Activity.Activity

  def create(params) do
    %Activity{}
    |> Activity.changeset(params)
    |> Repo.insert()
  end

  def all(params) do
    limit = Map.get(params, "limit", nil)

    from(a in Activity,
      limit: ^limit,
      order_by: [desc: a.occurred_at, desc: a.id]
    )
    |> Repo.all()
  end
end
