# In this is the state of the app

module Model
  module Direction
    UP = :up
    RIGHT = :right
    DOWN = :down
    LEFT = :left
  end
  class Coord < Struct.new(:row, :col)
  end

  class Food < Coord # herencia
  end

  class Snake < Struct.new(:positions)

  end

  class Grid < Struct.new(:rows, :cols)

  end

  class State < Struct.new(:snake, :food, :grid,
                           :current_direction,
                           :game_finished)

  end

  def self.init_state
    Model::State.new(
        Model::Snake.new([
                             Model::Coord.new(1, 1),
                             Model::Coord.new(0, 1)
                         ]),
        Model::Food.new(4, 4),
        Model::Grid.new(12, 16),
        Direction::DOWN,
        false
    )
  end
end