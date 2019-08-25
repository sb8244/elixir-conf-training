defmodule Example2.Activity.ActivityStore do
  alias Example2.Repo
  alias Example2.Activity.Activity

  def create(params) do
    %Activity{}
    |> Activity.changeset(params)
    |> Repo.insert()
  end

  def all(params) do
    Activity
    |> Repo.all()
  end
end
