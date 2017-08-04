defmodule InakaPongWeb.ScoreView do
  use InakaPongWeb, :view
  alias InakaPongWeb.ScoreView

  def render("index.json", %{scores: scores}) do
    render_many(scores, ScoreView, "score.json")
  end

  def render("show.json", %{score: score}) do
    render_one(score, ScoreView, "score.json")
  end

  def render("score.json", %{score: score}) do
    %{id: score.id,
      name: score.name,
      points: score.points}
  end
end
