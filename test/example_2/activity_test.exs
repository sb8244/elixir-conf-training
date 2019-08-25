defmodule Example2.ActivityTest do
  use Example2.DataCase, async: true

  alias Example2.Activity

  @valid_params %{
    who_id: 1,
    what: "edited a post",
    what_type: "edit",
    occurred_at: DateTime.utc_now() |> DateTime.truncate(:second),
    customer_tier: "A"
  }

  describe "create/1" do
    test "an invalid Activity has errors" do
      assert {:error, changeset} = Activity.create(%{})
      refute changeset.valid?
      assert changeset.errors |> length() == 5
    end

    test "a valid Activity can be created" do
      assert {:ok, activity} = Activity.create(@valid_params)
      assert activity.id
      Enum.each(@valid_params, fn {k, v} ->
        assert Map.get(activity, k) == v
      end)
    end
  end
end
