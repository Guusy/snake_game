# In this is the state of the app

module Model
  class Coord < Struct.new(:row, :col)
  end

  class Food < Coord # herencia
  end

  class Snake < Struct.new(:positions)

  end

  class Grid < Struct.new(:rows, :cols)

  end

  class State < Struct.new(:snake, :food, :grid)

  end

  def self.init_state
    Model::State.new(
        Model::Snake.new([
                             Model::Coord.new(1, 1),
                             Model::Coord.new(0, 1)
                         ]),
        Model::Food.new(4, 4),
        Model::Grid.new(8, 12)
    )
  end
end