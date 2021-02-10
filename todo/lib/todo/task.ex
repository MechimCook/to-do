
defmodule Todo.Task do
  @recurring_in_seconds %{"hour" => 3600, "day" => 86400, "week" => 604800, "year" => 3.154e+7}
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

  def repeat_task(%TaskSchema{dueDate: dueDate, recurring: recurring} = task) do

    time_added =
      Map.get(@recurring_in_seconds, recurring)

    Map.update(task, :dueDate, nil, fn current_due_date -> DateTime.add(current_due_date, time_added) end)
    |> Map.drop([:updated_at, :inserted_at, :id, :__meta__, :__struct__])
    |> create_task()
  end
end
