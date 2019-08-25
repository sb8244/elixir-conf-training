defmodule Example2.Repo.Migrations.CreateActivities do
  use Ecto.Migration

  def change do
    create table(:activities) do
      add :who_id, :integer
      add :what, :string
      add :what_type, :string
      add :occurred_at, :utc_datetime
      add :customer_tier, :string

      timestamps()
    end
  end
end
