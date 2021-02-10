defmodule Todo do

    import Supervisor.Spec

  def new_calander() do
    [{Todo.Server, pid, :worker, [Todo.Server]}| _]= Supervisor.which_children(Todo.Supervisor)
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

  def repeat(pid, task_id) do
    GenServer.call(pid, { :repeat, task_id})
  end

end
