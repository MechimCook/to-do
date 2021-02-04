defmodule Todo.Calender do

  alias Todo.{Calender, Task}

  defstruct(
    Name: "",
    ToDoList: []
  )


  def new_calender(), do: %Calender{ToDoList: Task.list_tasks}

  def get_task(%Calender{ToDoList: toDoList}, task_id) do
    Enum.find(toDoList, fn %{id: id} -> id == task_id end)
  end

  def update_task(calender = %Calender{ToDoList: toDoList}, task, attrs) do
    Task.update_task(task, attrs)
    |> update_helper(task, toDoList, calender)
  end

  def update_helper({:ok, newTask}, task, toDoList, calender) do
    toDoList
    |> List.delete(task)
    |> List.insert_at(0, newTask)
    |> reply_formater(:ok, newTask, calender)
  end

  def update_helper({:error, changeset}, _task, toDoList, calender), do:
    reply_formater(toDoList, :error, changeset, calender)

   def delete_task(calender = %Calender{ToDoList: toDoList}, task) do
     Task.delete_task(task)
     |> delete_helper(task, toDoList, calender)
   end

   def delete_helper({:ok, newTask}, task, toDoList, calender) do
     toDoList
     |> List.delete(task)
     |> List.insert_at(0, newTask)
     |> reply_formater(:ok, newTask, calender)
   end

   def delete_helper({:error, changeset}, _task, toDoList, calender), do:
     reply_formater(toDoList, :error, changeset, calender)

   def reply_formater(toDoList, reply, task, calender), do:
    {reply, task, %Calender{ calender | ToDoList: toDoList }}

    def create_task(calender = %Calender {ToDoList: toDoList}) do
      Task.create_task()
      |> create_helper([], toDoList, calender)
    end

  def create_task(calender = %Calender {ToDoList: toDoList}, attrs) do
    Task.create_task(attrs)
    |> create_helper(attrs, toDoList, calender)
  end

  def create_helper({:ok, newTask}, _task, toDoList, calender) do
    toDoList
    |> List.insert_at(0, newTask)
    |> reply_formater(:ok, newTask, calender)
  end

  def create_helper({:error, changeset}, _task, toDoList, calender), do:
    reply_formater(toDoList, :error, changeset, calender)


end
