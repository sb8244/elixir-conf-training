defmodule Example2.Activity do
  use Ecto.Schema
  import Ecto.Changeset

  schema "activities" do
    field :customer_tier, :string
    field :occurred_at, :utc_datetime
    field :what, :string
    field :what_type, :string
    field :who_id, :integer

    timestamps()
  end

  @doc false
  def changeset(activity, attrs) do
    activity
    |> cast(attrs, [:who_id, :what, :what_type, :occurred_at, :customer_tier])
    |> validate_required([:who_id, :what, :what_type, :occurred_at, :customer_tier])
  end
end
