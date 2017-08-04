defmodule InakaPongWeb.ScoreController do
  use InakaPongWeb, :controller

  alias InakaPong.Scores
  alias InakaPong.Scores.Score

  action_fallback InakaPongWeb.FallbackController

  def index(conn, _params) do
    scores = Scores.list_scores()
    render(conn, "index.json", scores: scores)
  end

  def create(conn, score_params) do
    with {:ok, %Score{} = score} <- Scores.create_score(score_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", score_path(conn, :show, score))
      |> render("show.json", score: score)
    end
  end

  def show(conn, %{"id" => id}) do
    score = Scores.get_score!(id)
    render(conn, "show.json", score: score)
  end

  def update(conn, params) do
    id = Map.get(params, "id")
    score_params = Map.delete(params, "id")
    score = Scores.get_score!(id)

    with {:ok, %Score{} = score} <- Scores.update_score(score, score_params) do
      render(conn, "show.json", score: score)
    end
  end

  def delete(conn, %{"id" => id}) do
    score = Scores.get_score!(id)
    with {:ok, %Score{}} <- Scores.delete_score(score) do
      send_resp(conn, :no_content, "")
    end
  end
end
