
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

  def update_task(%TaskSchema{recurring: recurring} = task, %{finished: true} = attrs) when recurring do
    repeat_task(task)
    task
    |> TaskSchema.changeset(attrs)
    |> Repo.update()
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

  def repeat_task(%TaskSchema{recurring: "month", dueDate: dueDate} = task) do
    time_added = Map.get(@recurring_in_seconds, "day") * Date.days_in_month(dueDate)

      task
      |> repeat_helper(time_added)
  end

  def repeat_task(%TaskSchema{recurring: recurring} = task) do
    time_added =
      Map.get(@recurring_in_seconds, recurring)

    repeat_helper(task, time_added)
  end

  def repeat_helper(task, time_added) do
    Map.update(task, :dueDate, nil, fn current_due_date -> DateTime.add(current_due_date, time_added) end)
    |> Map.drop([:updated_at, :inserted_at, :id, :__meta__, :__struct__])
    |> create_task()
  end

end
