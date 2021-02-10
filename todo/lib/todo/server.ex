defmodule Todo.Server do

  alias Todo.Calender
  use   GenServer

  def child_spec(arg) do
        %{
         id: __MODULE__,
         start: {__MODULE__, :start_link, [arg]},
         type: :worker
       }
      end

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(_) do
    { :ok, Calender.new_calender() }
  end

  def handle_call({ :list }, _from, calender) do
    { :reply, calender, calender }
  end

  def handle_call({ :get, task_id }, _from, calender) do
    task = Calender.get_task(calender, task_id)
    { :reply, task, calender }
  end

  def handle_call({ :delete, task_id }, _from, calender) do
     calender = Calender.delete_task(calender, task_id)
    { :reply, calender, calender }
  end

  def handle_call({ :edit, task_id, attrs }, _from, calender) do
    { reply, updated_task, calender } = Calender.update_task(calender, task_id, attrs)
    { :reply, reply, calender }
  end

  def handle_call({ :new, attrs }, _from, calender) do
    { reply, added, calender } = Calender.create_task(calender, attrs)
    { :reply, {reply, added}, calender }
  end

  def handle_call({ :new }, _from, calender) do
    changeset = Todo.Task.change_task(%Todo.TaskSchema{})
    { :reply, changeset, calender }
  end

  def handle_call({ :repeat, task_id }, _from, calender) do
     calender = Calender.repeat_task(calender, task_id)
    { :reply, calender, calender }
  end

  def handle_call({ :sort, attrs }, _from, calender) do
     calender = Calender.sort(calender, attrs)
    { :reply, calender, calender }
  end

end
