defmodule InakaPongWeb.PageController do
  use InakaPongWeb, :controller
  alias InakaPong.Scores

  def index(conn, _params) do
    scores = Scores.list_scores()
    render conn, "index.html", scores: scores
  end
end
