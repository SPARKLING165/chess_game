require_relative 'pieces.rb'

# clears the command prompt screen
class System
	def self.clear
		puts "\e[H\e[2J"
	end
end

class Game

	def is_game_over?
		false
	end

	def save_game 
	
	end

end



# Board class



class Board < Game

	attr_accessor :board, :player_turn

	def initialize(player_turn=1)
		@player_turn = player_turn
		@board = make_blank_board
	end

	def place_pieces(board)
		# W = White piece
		# B = Black piece
		board[7] = [Rook.new('W'), Knight.new('W'), Bishop.new('W'), 
								Queen.new('W'), King.new('W'), Bishop.new('W'), 
								Knight.new('W'), Rook.new('W')]
		board[0] = [Rook.new('B'), Knight.new('B'), Bishop.new('B'), 
								Queen.new('B'), King.new('B'), Bishop.new('B'), 
								Knight.new('B'), Rook.new('B')]
		board[6].map!{|position| Pawn.new('W')}
		board[1].map!{|position| Pawn.new('B')}
		board
	end

	def make_blank_board
		board = []
		8.times{board << Array.new([nil] * 8)}
		board = place_pieces(board)
		board
	end

	def draw_board
		# for testing purposes
		# @board.each{|row| puts row.to_s}
		@board.each_with_index do |row, row_index|
			piece_row = []

			row.each do |piece|
				if piece.nil?
					piece_row << ' '
					next
				end
				piece_in_unicode = piece.print_piece
				piece_row << piece_in_unicode
			end

			# print 8 through 1 descending on the side
			# of the board
			print "#{8 - row_index}  "
			puts piece_row.join(' ')
		end
		puts "\n   " + ('a'..'h').to_a.join(' ')
		puts
	end

	def move_piece(start_loc, end_loc)
		@board[end_loc[0]][end_loc[1]] =
			@board[start_loc[0]][start_loc[1]]
		@board[start_loc[0]][start_loc[1]] = nil
	end


	def get_piece_given_position(location)
		return @board[location[0]][location[1]]
	end

	# method is used to see whether or not
	# a piece can capture another piece
	def is_opposing_piece?(location)
		piece = get_piece_given_position(location)

		if (piece.color == 'W' && @player_turn == 2)
			return true
		elsif (piece.color == 'B' && @player_turn == 1)
			return true
		else
			return false
		end
	end

	def get_player_color
		return 'W' if @player_turn == 1
		return 'B'
	end

end
