#!/usr/bin/ruby

require './player'
require "minitest/autorun"

class TestPlayer < Minitest::Test

  def setup
    @players = [
      Player.new(111, 'AAA', 1),
      Player.new(222, 'BBB', 2),
      Player.new(333, 'CCC', 3),
      Player.new(444, 'DDD', 4),
    ]
  end

  def test_to_string
    p = Player.new(1, 'Suzuki', 11)
    assert p.to_s == 'id: 1, name: Suzuki, my_rank_position: 11'
  end

  def test_same_rank_nothing_to_do
    p = Player.new(222, 'BBB', 2)
    ret = Player.update_rank(@players, p, 2)
    assert Player::NOTD == ret
  end

  def test_edge_shrink_list_size_to_zero
    p = Player.new(111, 'AAA', 1)

    list_of_one = [
      Player.new(111, 'AAA', 1),
    ]

    Player.update_rank(list_of_one, p, 9999)

    assert_equal 0, list_of_one.size
    assert_equal 9999, p.my_rank_position
  end

  def test_new_rank_is_bad_greater_than_max_big_list
    p = Player.new(5555, 'EEE', 9999)
    old_size = @players.size
    ret = Player.update_rank(@players, p, 6)

    assert_equal Player::BADR, ret
    assert_equal old_size, @players.size
    assert_equal 9999, p.my_rank_position
  end
    
  def test_new_rank_is_ok_exactly_list_size_plus_one
    p = Player.new(5555, 'EEE', 9999)
    old_size = @players.size
    ret = Player.update_rank(@players, p, 5)

    assert_equal Player::OK, ret
    assert_equal old_size + 1, @players.size
    assert_equal 5, p.my_rank_position
  end

  def test_new_rank_is_bad_greater_than_max_list_of_one
    p = Player.new(1111, 'AAA', 9999)

    list_empty = []

    Player.update_rank(list_empty, p, 2)

    assert_equal 0, list_empty.size
    assert_equal 9999, p.my_rank_position
  end

  def test_new_rank_is_ok_is_one
    p = Player.new(1111, 'AAA', 9999)
    my_list = []

    assert_equal Player::OK, Player.update_rank(my_list, p, 1)
    assert_equal 1, my_list.size
    assert_equal 1, p.my_rank_position
  end

  def test_last_insert_bad
    p = Player.new(444, 'DDD', 4)

    assert_equal Player::ALRD, Player.update_rank(@players, p, 5)
    assert_equal 4, @players.size
  end

  # Fixtures for multiple tests
  [
    # Change current list
    { player: Player.new(111, 'AAA', 1), changes: [
      { new_pos: 2, list_size: 4, player_per_position: [
          [0, 222, 1],
          [1, 111, 2],
          [2, 333, 3],
          [3, 444, 4],
        ]
      },
      { new_pos: 3, list_size: 4, player_per_position: [
          [0, 222, 1],
          [1, 333, 2],
          [2, 111, 3],
          [3, 444, 4],
        ]
      },
      { new_pos: 4, list_size: 4, player_per_position: [
          [0, 222, 1],
          [1, 333, 2],
          [2, 444, 3],
          [3, 111, 4],
        ]
      }]
    },
    { player: Player.new(222, 'BBB', 2), changes: [
      { new_pos: 1, list_size: 4, player_per_position: [
          [0, 222, 1],
          [1, 111, 2],
          [2, 333, 3],
          [3, 444, 4],
        ]
      },
      { new_pos: 3, list_size: 4, player_per_position: [
          [0, 111, 1],
          [1, 333, 2],
          [2, 222, 3],
          [3, 444, 4],
        ]
      },
      { new_pos: 4, list_size: 4, player_per_position: [
          [0, 111, 1],
          [1, 333, 2],
          [2, 444, 3],
          [3, 222, 4],
        ]
      }]
    },
    { player: Player.new(333, 'CCC', 3), changes: [
      { new_pos: 1, list_size: 4, player_per_position: [
          [0, 333, 1],
          [1, 111, 2],
          [2, 222, 3],
          [3, 444, 4],
        ]
      },
      { new_pos: 2, list_size: 4, player_per_position: [
          [0, 111, 1],
          [1, 333, 2],
          [2, 222, 3],
          [3, 444, 4],
        ]
      },
      { new_pos: 4, list_size: 4, player_per_position: [
          [0, 111, 1],
          [1, 222, 2],
          [2, 444, 3],
          [3, 333, 4],
        ]
      }]
    },
    { player: Player.new(444, 'DDD', 4), changes: [
      { new_pos: 1, list_size: 4, player_per_position: [
          [0, 444, 1],
          [1, 111, 2],
          [2, 222, 3],
          [3, 333, 4],
        ]
      },
      { new_pos: 2, list_size: 4, player_per_position: [
          [0, 111, 1],
          [1, 444, 2],
          [2, 222, 3],
          [3, 333, 4],
        ]
      },
      { new_pos: 3, list_size: 4, player_per_position: [
          [0, 111, 1],
          [1, 222, 2],
          [2, 444, 3],
          [3, 333, 4],
        ]
      }]
    },
    # Remove player from list
    { player: Player.new(111, 'AAA', 1), changes: [
      { new_pos: 9999, list_size: 3, player_per_position: [
          [0, 222, 1],
          [1, 333, 2],
          [2, 444, 3],
        ]
      }]
    },
    { player: Player.new(222, 'BBB', 2), changes: [
      { new_pos: 9999, list_size: 3, player_per_position: [
          [0, 111, 1],
          [1, 333, 2],
          [2, 444, 3],
        ]
      }]
    },
    { player: Player.new(333, 'CCC', 3), changes: [
      { new_pos: 9999, list_size: 3, player_per_position: [
          [0, 111, 1],
          [1, 222, 2],
          [2, 444, 3],
        ]
      }]
    },
    { player: Player.new(444, 'DDD', 4), changes: [
      { new_pos: 9999, list_size: 3, player_per_position: [
          [0, 111, 1],
          [1, 222, 2],
          [2, 333, 3],
        ]
      }]
    },
    # Add player to list
    { player: Player.new(555, 'EEE', 9999), changes: [
      { new_pos: 1, list_size: 5, player_per_position: [
          [0, 555, 1],
          [1, 111, 2],
          [2, 222, 3],
          [3, 333, 4],
          [4, 444, 5],
        ]
      },
      { new_pos: 2, list_size: 5, player_per_position: [
          [0, 111, 1],
          [1, 555, 2],
          [2, 222, 3],
          [3, 333, 4],
          [4, 444, 5],
        ]
      },
      { new_pos: 3, list_size: 5, player_per_position: [
          [0, 111, 1],
          [1, 222, 2],
          [2, 555, 3],
          [3, 333, 4],
          [4, 444, 5],
        ]
      },
      { new_pos: 4, list_size: 5, player_per_position: [
          [0, 111, 1],
          [1, 222, 2],
          [2, 333, 3],
          [3, 555, 4],
          [4, 444, 5],
        ]
      },
      { new_pos: 5, list_size: 5, player_per_position: [
          [0, 111, 1],
          [1, 222, 2],
          [2, 333, 3],
          [3, 444, 4],
          [4, 555, 5],
        ]
      }]
    },
  ].each do |p|
    for change in p[:changes]

      define_method(
        "test_from_#{p[:player].my_rank_position}_to_#{change[:new_pos]}"
      ) do

        player = p[:player].clone
        ret = Player.update_rank(@players, player, change[:new_pos])

        assert_equal Player::OK, ret

        assert_equal change[:new_pos], player.my_rank_position

        assert_equal change[:list_size], @players.size

        change[:player_per_position].each do |info|
          index = info[0]
          id = info[1]
          rank = info[2]

          assert_equal id, @players[index].id
          assert_equal rank, @players[index].my_rank_position
        end
      end 
    end
  end

end
