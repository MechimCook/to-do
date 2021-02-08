
defmodule Todo.Task do

  @secondsToDay 86400
  @secondsToWeek 604800

  import Ecto.Query, warn: false
  alias Todo.{Repo, TaskSchema}

  def list_tasks do
    Repo.all(TaskSchema)
  end

  def get_task!(id), do: Repo.get!(TaskSchema, id)

  def create_task(attrs \\ %{}) do
    %TaskSchema{}
    |> TaskSchema.changeset(attrs)
    |> Repo.insert()
  end

  def update_task(%TaskSchema{} = task, attrs) do
    task
    |> TaskSchema.changeset(attrs)
    |> Repo.update()
  end

  def delete_task(%TaskSchema{} = task) do
    Repo.delete(task)
  end

  def change_task(%TaskSchema{} = task, attrs \\ %{}) do
    TaskSchema.changeset(task, attrs)
  end
end
