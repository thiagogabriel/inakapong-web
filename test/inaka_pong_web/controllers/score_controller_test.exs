defmodule InakaPongWeb.ScoreControllerTest do
  use InakaPongWeb.ConnCase

  alias InakaPong.Scores
  alias InakaPong.Scores.Score

  @create_attrs %{name: "some name", points: 42}
  @update_attrs %{name: "some updated name", points: 43}
  @invalid_attrs %{name: nil, points: nil}

  def fixture(:score) do
    {:ok, score} = Scores.create_score(@create_attrs)
    score
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all scores", %{conn: conn} do
      conn = get conn, score_path(conn, :index)
      assert json_response(conn, 200) == []
    end
  end

  describe "create score" do
    test "renders score when data is valid", %{conn: conn} do
      conn = post conn, score_path(conn, :create), @create_attrs
      assert %{"id" => id} = json_response(conn, 201)

      conn = get conn, score_path(conn, :show, id)
      assert json_response(conn, 200) == %{
        "id" => id,
        "name" => "some name",
        "points" => 42}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, score_path(conn, :create), @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update score" do
    setup [:create_score]

    test "renders score when data is valid", %{conn: conn, score: %Score{id: id} = score} do
      conn = put conn, score_path(conn, :update, score), @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)

      conn = get conn, score_path(conn, :show, id)
      assert json_response(conn, 200) == %{
        "id" => id,
        "name" => "some updated name",
        "points" => 43}
    end

    test "renders errors when data is invalid", %{conn: conn, score: score} do
      conn = put conn, score_path(conn, :update, score), @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete score" do
    setup [:create_score]

    test "deletes chosen score", %{conn: conn, score: score} do
      conn = delete conn, score_path(conn, :delete, score)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, score_path(conn, :show, score)
      end
    end
  end

  defp create_score(_) do
    score = fixture(:score)
    {:ok, score: score}
  end
end
