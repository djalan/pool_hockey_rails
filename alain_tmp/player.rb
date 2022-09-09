#!/usr/bin/ruby

class Player
  attr_accessor :id
  attr_accessor :name
  attr_accessor :my_rank_position

  NOTD = 'nothing to do'
  BADR = 'invalid new rank'
  ALRD = 'invalid rank: player already in list'
  OK = 'rank(s) updated'

  def initialize(id, name, my_rank_position)
    @id = id
    @name = name
    @my_rank_position = my_rank_position
  end

  def to_s
    "id: #{@id}, name: #{@name}, my_rank_position: #{my_rank_position}"
  end

  # def ==(other)
  #   id == other.id
  # end

  # class method
  def self.remove_last(list)
    list.pop
  end

  def self.update_rank(list, player, new_rank)
    
    return NOTD if player.my_rank_position == new_rank

    if new_rank != 9999
      if (list.size > 0) && (new_rank > list.size)
        return BADR if new_rank != (list.size + 1)
      elsif list.size == 0
        return BADR if new_rank != 1
      end
    end

    index = list.index{ |p| p.id == player.id }
    if index != nil
      return ALRD if new_rank == (list.size + 1)
      list.delete_at(index)
    end

    if new_rank == 9999
      player.my_rank_position = 9999
    else
      list.insert(new_rank - 1, player)
    end

    if new_rank < player.my_rank_position
      i = new_rank - 1
    else
      i = index
    end
    while i < list.size
      break if list[i].my_rank_position == (i + 1)
      list[i].my_rank_position = (i + 1)
      i += 1
    end

    # for p in list
    #   puts p
    # end

    return OK
  end
end
