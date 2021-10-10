require 'test_helper'

class PlayersControllerTest < ActionController::TestCase
  setup do
    @player = players(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:players)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create player" do
    assert_difference('Player.count') do
      post :create, player: { assists: @player.assists, goals: @player.goals, last_team: @player.last_team, name: @player.name, nhl_assists: @player.nhl_assists, nhl_goals: @player.nhl_goals, nhl_points: @player.nhl_points, nhl_rank: @player.nhl_rank, points: @player.points, position: @player.position, power_play: @player.power_play, pp_last_year: @player.pp_last_year, rank: @player.rank, salary: @player.salary, team: @player.team }
    end

    assert_redirected_to player_path(assigns(:player))
  end

  test "should show player" do
    get :show, id: @player
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @player
    assert_response :success
  end

  test "should update player" do
    patch :update, id: @player, player: { assists: @player.assists, goals: @player.goals, last_team: @player.last_team, name: @player.name, nhl_assists: @player.nhl_assists, nhl_goals: @player.nhl_goals, nhl_points: @player.nhl_points, nhl_rank: @player.nhl_rank, points: @player.points, position: @player.position, power_play: @player.power_play, pp_last_year: @player.pp_last_year, rank: @player.rank, salary: @player.salary, team: @player.team }
    assert_redirected_to player_path(assigns(:player))
  end

  test "should destroy player" do
    assert_difference('Player.count', -1) do
      delete :destroy, id: @player
    end

    assert_redirected_to players_path
  end
end
