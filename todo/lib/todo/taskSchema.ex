defmodule Todo.TaskSchema do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :Title, :string
    field :Description, :string
    field :DueDate, :utc_datetime
    field :Priority, :integer, default: 0
    field :Labels, {:array, :string}

    timestamps()
  end

  def changeset(struct, params) do
  struct
  |> cast(params, [:Title, :Description, :DueDate, :Priority, :Labels])
  |> validate_required([:Title])
end
end
