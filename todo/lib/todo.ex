defmodule Todo do

    import Supervisor.Spec

  def new_calander() do
    { :ok, pid } = Supervisor.start_child(Todo.Supervisor, Todo.Server.child_spec([]))
    pid
  end

  def get(pid) do
    GenServer.call(pid, { :list })
  end

  def get(pid, task_id) do
    GenServer.call(pid, { :get, task_id })
  end

  def delete(pid, task_id) do
    GenServer.call(pid, { :delete, task_id})
  end

  def edit(pid, task_id, attrs) do
    GenServer.call(pid, { :edit, task_id, attrs})
  end
  def new(pid) do
    GenServer.call(pid, { :new })
  end
  def new(pid, attrs) do
    GenServer.call(pid, { :new, attrs})
  end


end
