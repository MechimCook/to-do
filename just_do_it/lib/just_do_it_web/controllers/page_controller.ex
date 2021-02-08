defmodule JustDoItWeb.PageController do
  use JustDoItWeb, :controller

  def index(conn, _params) do
    pid = Todo.new_calander()
    calender = Todo.get(pid)

    conn
    |> put_session(:pid, pid)
    render(conn, "index.html", calender: calender )
  end
end
