def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input.to_i - 1
end

def move(arr, i, char='X')
  arr[i] = char
  arr
end

WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],

  [0,3,6],
  [1,4,7],
  [2,5,8],

  [0,4,8],
  [2,4,6]
]

def won?(board)
  # players = ["X", "O"]
  WIN_COMBINATIONS.each do |combo|
    first_position = board[combo[0]]
    if !first_position.nil? && first_position != " "
      if combo.all? {|space| board[space] == first_position}
        return combo
      end
    end
  end
  false
end

def full?(board)
  return board.all? {|space| space == "X" || space == "O"}
end

def draw?(board)
  return full?(board) && !won?(board)
end

def over?(board)
  return won?(board) || full?(board)
end

def winner(board)
  combo = won?(board)
  if combo
    return board[combo[0]]
  else
    return nil
  end
end

# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  !position_taken?(board, index) && index >= 0 && index < board.size
end



def turn_count(board)
  t = 0
  board.each do | space |
    if space == 'X' || space == 'O'
      t +=1
    end
  end
  t
end

def current_player(board)
  if turn_count(board) % 2 == 1
    'O'
  else
    'X'
  end
end


# TODO: should infer player
def move(board, i, player)
  # if valid_move?(board, i)
  board[i] = player
  # end
  return board
end

def turn(board)
  puts "Please enter 1-9 for player #{current_player(board)}:"
  i = gets.strip
  # ask for input after failed validation
  i = input_to_index(i)
  while !valid_move?(board, i)
    puts "Please enter 1-9 for player #{current_player(board)}:"
    i = gets.strip
    # ask for input after failed validation
    i = input_to_index(i)
  end
  move(board, i, current_player(board))
  display_board(board)
end

def play(board)
  while !over?(board) && !draw?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end
