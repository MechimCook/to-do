defmodule Todo.TaskSchema do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :title, :string, default: "new"
    field :description, :string
    field :dueDate, :utc_datetime
    field :priority, :integer, default: 0
    field :labels, {:array, :string}

    timestamps()
  end

  def changeset(struct, params) do
  struct
  |> cast(params, [:title, :description, :dueDate, :priority, :labels])
  |> validate_required([:title])
end
end
