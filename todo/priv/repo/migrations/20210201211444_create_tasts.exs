defmodule Todo.Repo.Migrations.CreateTasts do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :Title, :string
      add :Description, :string
      add :DueDate, :utc_datetime
      add :Priority, :integer, default: 0
      add :Labels, {:array, :string}

      timestamps()
    end
  end
end
