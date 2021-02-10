defmodule Todo.Repo.Migrations.CreateTasts do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :title, :string
      add :description, :string
      add :dueDate, :utc_datetime
      add :priority, :integer, default: 0
      add :labels, {:array, :string}
      add :recurring, :string
      add :finished, :boolean

      timestamps()
    end
  end
end
