defmodule InakaPong.Scores.Score do
  use Ecto.Schema
  import Ecto.Changeset
  alias InakaPong.Scores.Score


  schema "scores" do
    field :name, :string
    field :points, :integer

    timestamps()
  end

  @doc false
  def changeset(%Score{} = score, attrs) do
    score
    |> cast(attrs, [:name, :points])
    |> validate_required([:name, :points])
  end
end
