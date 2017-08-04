defmodule InakaPong.Repo.Migrations.CreateScores do
  use Ecto.Migration

  def change do
    create table(:scores) do
      add :name, :string
      add :points, :integer

      timestamps()
    end

  end
end
