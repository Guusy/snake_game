# receive state and return a new one
module Actions
  def self.move_snake(state)
    next_direction = state.current_direction
    next_position = calc_next_position(state)
    # verify the next pixel is valid and move or if not valid, finish the game.
    if position_is_food?(state, next_position)
      grow_snake_too(state, next_position)
      generate_food(state)
    elsif position_is_valid?(state, next_position)
      return move_snake_to(state, next_position)
    else
      return end_game(state)
    end
  end

  def self.change_direction(state, direction)
    if next_direction_is_valid?(state, direction)
      state.current_direction = direction
    else
      puts "Invalid direction"
    end
    state
  end

  private

  def self.generate_food(state)
    new_food = Model::Food.new(rand(state.grid.rows), rand(state.grid.cols))
    state.food = new_food
    state
  end

  def self.position_is_food?(state, next_position)
    state.food.row == next_position.row && state.food.col == next_position.col
  end

  def self.calc_next_position(state)
    current_position = state.snake.positions.first
    case state.current_direction
    when Model::Direction::UP
      # decrement row
      return Model::Coord.new(current_position.row - 1, current_position.col)
    when Model::Direction::RIGHT
      # increment row
      return Model::Coord.new(current_position.row, current_position.col + 1)
    when Model::Direction::DOWN
      return Model::Coord.new(current_position.row + 1, current_position.col)
    when Model::Direction::LEFT
      return Model::Coord.new(current_position.row, current_position.col - 1)
    end
  end

  def self.position_is_valid?(state, position)
    is_invalid = ((position.row >= state.grid.rows ||
        position.row < 0) || (
    position.col >= state.grid.cols ||
        position.col < 0
    ))
    return false if is_invalid

    return !(state.snake.positions.include? position)
  end

  def self.move_snake_to(state, next_position)
    new_positions = [next_position] + state.snake.positions[0...-1]
    state.snake.positions = new_positions
    state
  end

  def self.end_game(state)
    state.game_finished = true
    state
  end

  def self.next_direction_is_valid?(state, direction)
    case state.current_direction
    when Model::Direction::UP
      return true if direction != Model::Direction::DOWN
    when Model::Direction::DOWN
      return true if direction != Model::Direction::UP
    when Model::Direction::RIGHT
      return true if direction != Model::Direction::LEFT
    when Model::Direction::LEFT
      return true if direction != Model::Direction::RIGHT
    end
    return false
  end

  def self.grow_snake_too(state, next_position)
    state.snake.positions = [next_position] + state.snake.positions
    state
  end

end