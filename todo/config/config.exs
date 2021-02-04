import Config


config :todo, ecto_repos: [Todo.Repo]

config :todo, Todo.Repo,
  database: "todo_repo",
  username: "postgres",
  password: "",
  hostname: "localhost",
  port: "5432"
