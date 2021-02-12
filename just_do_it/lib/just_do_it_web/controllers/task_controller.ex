defmodule JustDoItWeb.TaskController do
  use JustDoItWeb, :controller


  def index(conn, _params) do
    pid = Todo.new_calander()
    tasks = Todo.get(pid)

    conn = put_session(conn, :pid, pid)
    render(conn, "index.html", tasks: tasks)
  end

  def sorted_index(conn, params) do
    pid = Todo.new_calander()
    tasks = Todo.sort(pid, params)

    conn = put_session(conn, :pid, pid)
    render(conn, "index.html", tasks: tasks)
  end

  def new(conn, _params) do
    changeset =
      get_session(conn, :pid)
      |> Todo.new()
      |> IO.inspect()
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"task_schema" => task_params}) do
    pid = get_session(conn, :pid)
    case Todo.new(pid, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: Routes.task_path(conn, :show, task))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    task =
      get_session(conn, :pid)
      |> Todo.get(String.to_integer(id))
    render(conn, "show.html", task: task)
  end

  def edit(conn, %{"id" => id}) do
    changeset =
      get_session(conn, :pid)
      |> Todo.new()

    task =
    get_session(conn, :pid)
    |> Todo.get(String.to_integer(id))
    render(conn, "edit.html", task: task, changeset: changeset)
  end

  def update(conn, %{"id" => id, "task_schema" => task_params}) do

    pid = get_session(conn, :pid)
    case Todo.edit(pid, id, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: Routes.task_path(conn, :show, task))

      {:error, %Ecto.Changeset{} = changeset} ->
        task =
        get_session(conn, :pid)
        |> Todo.get(id)
        render(conn, "edit.html", task: task, changeset: changeset)
      :ok ->
        task =
        get_session(conn, :pid)
        |> Todo.get(String.to_integer(id))
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: Routes.task_path(conn, :show, task))
    end
  end

  def delete(conn, %{"id" => id}) do
    get_session(conn, :pid)
    |> Todo.delete(String.to_integer(id))

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: Routes.task_path(conn, :index))
  end


end
