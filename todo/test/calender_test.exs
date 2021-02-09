defmodule CalendarTest do
  use ExUnit.Case
  alias Todo.Calender


  setup_all do
    {:ok, task, calender} =
      Calender.new_calender()
      |> Calender.create_task()
    {:ok, state: {task, calender}}
  end

  test "get_task", state do
      {task, calender} = state[:state]
      assert Calender.get_task(calender, task.id) == task
  end

  test "update_task", state do
    {task, calender} = state[:state]
    {:ok, new_task, calender} = Calender.update_task(calender, task.id, %{title: "test"})
    assert Calender.get_task(calender, task.id) == new_task
  end

  test "delete_task", state do
    {task, calender} = state[:state]
    {:ok, _deleted_task, calender} = Calender.delete_task(calender, task)
    assert Calender.get_task(calender, task.id) == nil
  end
end
